#!/usr/bin/env python3
"""
🎬 AVATAR VIDEO PRODUCER - COLAB SETUP
Instala todas as dependências otimizadas para Google Colab
"""

import os
import subprocess
import sys

def run_cmd(cmd, description=""):
    """Executa comando com feedback"""
    if description:
        print(f"\n📦 {description}...")
    print(f"→ {cmd}")
    result = subprocess.run(cmd, shell=True, capture_output=False)
    if result.returncode != 0:
        print(f"⚠️  Aviso durante: {description}")
    return result.returncode == 0

def main():
    print("=" * 60)
    print("🎬 AVATAR VIDEO PRODUCER - GOOGLE COLAB SETUP")
    print("=" * 60)
    
    # 1. Atualizar pip
    run_cmd("pip install --upgrade pip -q", "Atualizando pip")
    
    # 2. Dependências do sistema (Colab já tem a maioria)
    print("\n✅ Colab já possui: FFmpeg, CUDA, PyTorch")
    
    # 3. Dependências Python essenciais
    deps = [
        "numpy==1.24.3",
        "scipy>=1.10.0",
        "scikit-image>=0.21.0",
        "opencv-python-headless>=4.8.0",
        "Pillow>=10.0.0",
        "imageio>=2.31.0",
        "librosa>=0.10.0",
        "soundfile>=0.12.0",
        "torch>=2.0.0",
        "torchvision>=0.15.0",
        "torchaudio>=2.0.0",
        "requests>=2.31.0",
        "pydub>=0.25.1",
        "pexpect>=4.8.0",
        "mediapipe>=0.10.0",
    ]
    
    print("\n📥 Instalando dependências Python...")
    for dep in deps:
        run_cmd(f"pip install {dep} -q", f"  → {dep.split('==')[0]}")
    
    # 4. Instalar Fish Speech (TTS melhor qualidade)
    print("\n🎤 Instalando Fish Speech (TTS)...")
    run_cmd("pip install fish-speech -q", "Fish Speech")
    
    # 5. Downloader de modelos
    print("\n🤖 Preparando downloads de modelos...")
    run_cmd("pip install gdown -q", "gdown (para download do drive)")
    
    # 6. Criar diretórios necessários
    dirs = [
        "/content/avatar-producer/inputs",
        "/content/avatar-producer/outputs",
        "/content/avatar-producer/models",
        "/content/avatar-producer/audio",
        "/content/avatar-producer/temp"
    ]
    
    for d in dirs:
        os.makedirs(d, exist_ok=True)
        print(f"✅ Criado: {d}")
    
    print("\n" + "=" * 60)
    print("✅ SETUP CONCLUÍDO COM SUCESSO!")
    print("=" * 60)
    print("\n🚀 Próximos passos:")
    print("1. Execute: !python /content/avatar-producer/download_models.py")
    print("2. Use o notebook: colab_avatar_video.ipynb")
    print("\n" + "=" * 60)

if __name__ == "__main__":
    main()
