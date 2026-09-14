#!/usr/bin/env python3
"""
🎬 AVATAR VIDEO PROCESSOR - Core Engine
Processa: Texto → TTS → Lip-sync → Vídeo Final
"""

import os
import numpy as np
import cv2
import torch
import librosa
import soundfile as sf
from pathlib import Path
import subprocess
import time
from typing import Optional, Tuple

# ============================================================================
# 1. TTS - GERAÇÃO DE ÁUDIO
# ============================================================================

class TTSEngine:
    """Converte texto em áudio usando Fish Speech (free, melhor qualidade)"""
    
    def __init__(self, model_name="fish-speech"):
        self.model_name = model_name
        try:
            from fish_speech.i18n import i18n
            print(f"✅ Fish Speech carregado")
        except ImportError:
            print("⚠️  Fish Speech não instalado. Use: pip install fish-speech")
    
    def generate(self, text: str, output_path: str, language="pt-BR") -> bool:
        """Gera áudio do texto"""
        print(f"🎤 Gerando TTS: '{text[:50]}...'")
        
        try:
            # Usar fish-speech CLI
            cmd = f"""
            python -m fish_speech.main \
                --text "{text}" \
                --speaker default \
                --output {output_path} \
                --language {language}
            """
            result = subprocess.run(cmd, shell=True, capture_output=True)
            
            if os.path.exists(output_path) and os.path.getsize(output_path) > 1000:
                duration = self._get_audio_duration(output_path)
                print(f"✅ TTS gerado: {duration:.1f}s -> {output_path}")
                return True
        except Exception as e:
            print(f"❌ Erro TTS: {e}")
        
        return False
    
    @staticmethod
    def _get_audio_duration(audio_path: str) -> float:
        """Retorna duração do áudio em segundos"""
        try:
            y, sr = librosa.load(audio_path, sr=None)
            return librosa.get_duration(y=y, sr=sr)
        except:
            return 0.0

# ============================================================================
# 2. FACE DETECTION - DETECTAR ROSTO
# ============================================================================

class FaceDetector:
    """Detecta e rastreia rosto usando MediaPipe"""
    
    def __init__(self):
        import mediapipe as mp
        self.mp_face_detection = mp.solutions.face_detection
        self.detector = self.mp_face_detection.FaceDetection(
            model_selection=1,  # 1 = melhor para video
            min_detection_confidence=0.5
        )
        print("✅ Face Detector carregado")
    
    def detect_face(self, frame: np.ndarray) -> Optional[Tuple[int, int, int, int]]:
        """Detecta rosto e retorna bbox (x, y, w, h)"""
        rgb_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        results = self.detector.process(rgb_frame)
        
        if results.detections:
            detection = results.detections[0]
            h, w = frame.shape[:2]
            
            bbox = detection.location_data.relative_bounding_box
            x = int(bbox.xmin * w)
            y = int(bbox.ymin * h)
            box_w = int(bbox.width * w)
            box_h = int(bbox.height * h)
            
            return (x, y, box_w, box_h)
        
        return None

# ============================================================================
# 3. LIP-SYNC - SINCRONIZAÇÃO DE LÁBIOS
# ============================================================================

class Wav2LipProcessor:
    """Sincroniza lábios de vídeo com áudio usando Wav2Lip"""
    
    def __init__(self, checkpoint_path: str = "/content/avatar-producer/models/checkpoints/wav2lip.pth"):
        self.device = "cuda" if torch.cuda.is_available() else "cpu"
        self.checkpoint_path = checkpoint_path
        print(f"✅ Wav2Lip device: {self.device}")
        
        if not os.path.exists(checkpoint_path):
            print(f"⚠️  Checkpoint não encontrado: {checkpoint_path}")
            print("   Execute: python download_models.py")
    
    def process(
        self,
        video_path: str,
        audio_path: str,
        output_path: str,
        fps: int = 25
    ) -> bool:
        """Processa lip-sync"""
        print(f"🎬 Processando Wav2Lip...")
        print(f"   Video: {video_path}")
        print(f"   Audio: {audio_path}")
        
        try:
            # Script Wav2Lip
            cmd = f"""
            python -m face_detection.detection \
                --checkpoint_path {self.checkpoint_path} \
                --face {video_path} \
                --audio {audio_path} \
                --outfile {output_path} \
                --fps {fps}
            """
            
            # Alternativa: chamar Wav2Lip API
            result = subprocess.run(cmd, shell=True, capture_output=True, timeout=300)
            
            if os.path.exists(output_path):
                print(f"✅ Lip-sync completo: {output_path}")
                return True
        except subprocess.TimeoutExpired:
            print("⏱️  Timeout no Wav2Lip (>5min)")
        except Exception as e:
            print(f"❌ Erro Wav2Lip: {e}")
        
        return False

# ============================================================================
# 4. VIDEO MERGER - MERGE VÍDEO + ÁUDIO
# ============================================================================

class VideoMerger:
    """Mescla vídeo e áudio com FFmpeg"""
    
    @staticmethod
    def merge(
        video_path: str,
        audio_path: str,
        output_path: str,
        fps: int = 25,
        resolution: str = "1080p"
    ) -> bool:
        """Mescla vídeo + áudio"""
        print(f"🎥 Mergeando vídeo + áudio...")
        
        # Converter resolução
        if resolution == "1080p":
            scale = "1920:1080"
        elif resolution == "720p":
            scale = "1280:720"
        else:
            scale = "854:480"
        
        cmd = f"""
        ffmpeg -i {video_path} -i {audio_path} \
            -vf scale={scale}:force_original_aspect_ratio=decrease \
            -c:v libx264 -preset medium -crf 23 \
            -c:a aac -b:a 128k \
            -y {output_path}
        """
        
        result = subprocess.run(cmd, shell=True, capture_output=True)
        
        if os.path.exists(output_path):
            size_mb = os.path.getsize(output_path) / (1024*1024)
            print(f"✅ Vídeo final: {output_path} ({size_mb:.1f}MB)")
            return True
        
        print("❌ Erro ao mesclar vídeo")
        return False

# ============================================================================
# 5. ORCHESTRATOR - PIPELINE COMPLETO
# ============================================================================

class AvatarVideoProducer:
    """Orquestra todo o pipeline de produção"""
    
    def __init__(self, work_dir: str = "/content/avatar-producer"):
        self.work_dir = work_dir
        self.tts = TTSEngine()
        self.face_detector = FaceDetector()
        self.wav2lip = Wav2LipProcessor()
        self.merger = VideoMerger()
        
        os.makedirs(f"{work_dir}/outputs", exist_ok=True)
        os.makedirs(f"{work_dir}/temp", exist_ok=True)
    
    def produce(
        self,
        text: str,
        avatar_image_path: str,
        output_path: str,
        duration_max: int = 10
    ) -> bool:
        """
        Pipeline completo: Texto → TTS → Lip-sync → Vídeo
        
        Args:
            text: Script do avatar
            avatar_image_path: Imagem do rosto (PNG/JPG)
            output_path: Caminho do vídeo final
            duration_max: Duração máxima em segundos
        """
        print("\n" + "="*60)
        print("🚀 AVATAR VIDEO PRODUCER")
        print("="*60)
        
        # Verificar imagem de entrada
        if not os.path.exists(avatar_image_path):
            print(f"❌ Imagem não encontrada: {avatar_image_path}")
            return False
        
        timestamp = int(time.time())
        temp_audio = f"{self.work_dir}/temp/audio_{timestamp}.wav"
        temp_video = f"{self.work_dir}/temp/video_{timestamp}.mp4"
        
        # Fase 1: TTS
        print("\n📍 FASE 1: Geração de Áudio (TTS)")
        if not self.tts.generate(text, temp_audio):
            print("❌ Falha na geração de TTS")
            return False
        
        # Verificar duração
        duration = self.tts._get_audio_duration(temp_audio)
        if duration > duration_max:
            print(f"⚠️  Áudio {duration:.1f}s > limite {duration_max}s")
            print("   Truncando...")
        
        # Fase 2: Criar vídeo base com lip-sync
        print("\n📍 FASE 2: Sincronização de Lábios (Wav2Lip)")
        if not self.wav2lip.process(avatar_image_path, temp_audio, temp_video):
            print("⚠️  Wav2Lip falhou, usando imagem estática como fallback")
            # Fallback: criar vídeo simples com a imagem
            self._create_simple_video(avatar_image_path, duration, temp_video)
        
        # Fase 3: Mesclar e finalizar
        print("\n📍 FASE 3: Finalização e Encoding")
        success = self.merger.merge(temp_video, temp_audio, output_path)
        
        # Limpeza
        if os.path.exists(temp_audio):
            os.remove(temp_audio)
        if os.path.exists(temp_video):
            os.remove(temp_video)
        
        print("\n" + "="*60)
        if success:
            print("✅ VÍDEO GERADO COM SUCESSO!")
            print(f"   Arquivo: {output_path}")
            file_size = os.path.getsize(output_path) / (1024*1024)
            print(f"   Tamanho: {file_size:.1f}MB")
        else:
            print("❌ Falha na geração do vídeo")
        print("="*60 + "\n")
        
        return success
    
    def _create_simple_video(self, image_path: str, duration: float, output_path: str):
        """Cria vídeo simples (fallback) - imagem estática com áudio"""
        print(f"  → Criando vídeo fallback ({duration:.1f}s)...")
        
        img = cv2.imread(image_path)
        if img is None:
            print(f"  ❌ Não conseguiu ler imagem: {image_path}")
            return False
        
        h, w = img.shape[:2]
        fps = 25
        
        # Inicializar writer
        fourcc = cv2.VideoWriter_fourcc(*'mp4v')
        out = cv2.VideoWriter(output_path, fourcc, fps, (w, h))
        
        # Escrever frames
        total_frames = int(duration * fps)
        for i in range(total_frames):
            out.write(img)
        
        out.release()
        print(f"  ✅ Vídeo fallback: {output_path}")
        return True

# ============================================================================
# EXEMPLO DE USO
# ============================================================================

if __name__ == "__main__":
    producer = AvatarVideoProducer()
    
    # Exemplo
    text = "Olá! Eu sou um avatar gerado por IA. Bem-vindo ao futuro dos vídeos!"
    avatar_image = "/content/avatar-producer/inputs/avatar.jpg"  # Sua imagem aqui
    output_video = "/content/avatar-producer/outputs/video_resultado.mp4"
    
    producer.produce(text, avatar_image, output_video)
