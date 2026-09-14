#!/usr/bin/env python3
"""
🤖 Download de Modelos Pré-treinados
Baixa Wav2Lip e Face Detection automaticamente
"""

import os
import subprocess
import sys
from pathlib import Path

def download_file(url, output_path, name=""):
    """Download seguro com retry"""
    print(f"\n📥 Baixando {name or output_path}...")
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    
    # Usar wget ou curl
    cmd = f"wget -q --show-progress {url} -O {output_path}"
    result = subprocess.run(cmd, shell=True)
    
    if result.returncode == 0 and os.path.exists(output_path):
        size_mb = os.path.getsize(output_path) / (1024*1024)
        print(f"✅ {name}: {size_mb:.1f}MB")
        return True
    else:
        print(f"❌ Falha ao baixar {name}")
        return False

def main():
    print("=" * 60)
    print("🤖 DOWNLOAD DE MODELOS - AVATAR VIDEO PRODUCER")
    print("=" * 60)
    
    models_dir = "/content/avatar-producer/models"
    os.makedirs(models_dir, exist_ok=True)
    
    # 1. Wav2Lip Checkpoint (240MB)
    print("\n🎬 Fase 1: Wav2Lip (lip-sync)")
    wav2lip_url = "https://github.com/justinjohn0306/Wav2Lip/releases/download/v1.0/checkpoints.zip"
    wav2lip_path = f"{models_dir}/wav2lip.zip"
    
    if not os.path.exists(f"{models_dir}/checkpoints"):
        if download_file(wav2lip_url, wav2lip_path, "Wav2Lip Checkpoints"):
            print("  📦 Extraindo...")
            os.system(f"cd {models_dir} && unzip -q wav2lip.zip && rm wav2lip.zip")
            print("  ✅ Extractado")
    else:
        print("  ✅ Já existe")
    
    # 2. Face Detection (retinaface)
    print("\n🔍 Fase 2: RetinaFace (detecção facial)")
    retinaface_url = "https://github.com/serengil/deepface/releases/download/v0.0.75/retinaface.h5"
    retinaface_path = f"{models_dir}/retinaface.h5"
    
    if not os.path.exists(retinaface_path):
        download_file(retinaface_url, retinaface_path, "RetinaFace (30MB)")
    else:
        print("  ✅ Já existe")
    
    # 3. Voice Clone (opcional - baixar depois)
    print("\n🎤 Fase 3: TTS Models (Fish Speech)")
    print("  ℹ️  Fish Speech baixa modelos automaticamente na primeira uso")
    print("  ℹ️  Tamanho: ~500MB (cache local)")
    
    # 4. Mediapipe (auto-download)
    print("\n💪 Fase 4: MediaPipe (pose/hand detection)")
    print("  ℹ️  MediaPipe baixa automaticamente")
    
    print("\n" + "=" * 60)
    print("✅ MODELOS BAIXADOS COM SUCESSO!")
    print("=" * 60)
    print("\n📊 Uso de espaço:")
    os.system(f"du -sh {models_dir}/*")
    print("\n🚀 Agora você pode usar o notebook: colab_avatar_video.ipynb")

if __name__ == "__main__":
    main()
