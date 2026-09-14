@echo off
REM 🎬 AVATAR VIDEO PRODUCER - INSTALADOR WINDOWS
REM Execute este arquivo como administrador
REM Duplo clique ou: cmd.exe e digite: install.bat

setlocal enabledelayedexpansion

cls
echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║  🎬 AVATAR VIDEO PRODUCER - INSTALADOR WINDOWS            ║
echo ║  Produz vídeos com avatar falando (até 10s)                ║
echo ║  100%% GRÁTIS                                               ║
echo ╚════════════════════════════════════════════════════════════╝
echo.
echo ⚠️  REQUISITOS:
echo    • Python 3.8+ instalado
echo    • 5GB de espaço livre
echo    • Conexão internet
echo.
pause

REM Verificar Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Python não encontrado!
    echo.
    echo Instale em: https://www.python.org/downloads/
    echo (Marque "Add Python to PATH" durante instalação)
    echo.
    pause
    exit /b 1
)

for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
echo ✅ Python %PYTHON_VERSION% encontrado
echo.

REM Criar diretórios
echo 📁 Criando diretórios...
if not exist "avatar-producer" mkdir avatar-producer
cd avatar-producer
if not exist "inputs" mkdir inputs
if not exist "outputs" mkdir outputs
if not exist "models" mkdir models
if not exist "temp" mkdir temp
if not exist "audio" mkdir audio
echo ✅ Diretórios criados
echo.

REM Atualizar pip
echo 📦 Atualizando pip...
python -m pip install --upgrade pip -q
echo ✅ Pip atualizado
echo.

REM Instalar dependências
echo 📥 Instalando dependências Python...
echo    (isso pode levar 5-10 minutos)
echo.

python -m pip install -q numpy==1.24.3
echo    ✓ numpy
python -m pip install -q scipy>=1.10.0
echo    ✓ scipy
python -m pip install -q scikit-image>=0.21.0
echo    ✓ scikit-image
python -m pip install -q opencv-python>=4.8.0
echo    ✓ opencv-python
python -m pip install -q Pillow>=10.0.0
echo    ✓ Pillow
python -m pip install -q imageio>=2.31.0
echo    ✓ imageio
python -m pip install -q librosa>=0.10.0
echo    ✓ librosa
python -m pip install -q soundfile>=0.12.0
echo    ✓ soundfile
python -m pip install -q torch torchvision torchaudio
echo    ✓ torch/torchvision/torchaudio
python -m pip install -q requests>=2.31.0
echo    ✓ requests
python -m pip install -q pydub>=0.25.1
echo    ✓ pydub
python -m pip install -q pexpect>=4.8.0
echo    ✓ pexpect
python -m pip install -q mediapipe>=0.10.0
echo    ✓ mediapipe
python -m pip install -q gdown>=4.7.0
echo    ✓ gdown
python -m pip install -q imageio-ffmpeg
echo    ✓ imageio-ffmpeg

echo.
echo ✅ Dependências instaladas!
echo.

REM Verificar FFmpeg
echo 🎬 Verificando FFmpeg...
where ffmpeg >nul 2>&1
if %errorlevel% neq 0 (
    echo ⚠️  FFmpeg não encontrado!
    echo.
    echo Para instalar FFmpeg no Windows:
    echo    1. Acesse: https://ffmpeg.org/download.html
    echo    2. Clique em "Windows builds by BtbN"
    echo    3. Baixe a versão "full"
    echo    4. Descompacte em C:\ffmpeg
    echo    5. Adicione C:\ffmpeg\bin ao PATH do Windows
    echo.
    echo Ou use Chocolatey:
    echo    choco install ffmpeg
    echo.
    pause
) else (
    for /f "tokens=*" %%i in ('ffmpeg -version 2^>^&1 ^| findstr /R "ffmpeg version"') do set FFMPEG_VERSION=%%i
    echo ✅ !FFMPEG_VERSION!
)

echo.
echo 🤖 Baixando modelos pré-treinados...
echo    Wav2Lip Checkpoints (240MB)...
echo.

cd models

if not exist "checkpoints\wav2lip.pth" (
    echo Baixando... (pode levar 5-10 minutos)
    REM Usar PowerShell para download
    powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://github.com/justinjohn0306/Wav2Lip/releases/download/v1.0/checkpoints.zip' -OutFile 'checkpoints.zip'; Expand-Archive -Path 'checkpoints.zip' -DestinationPath '.'; Remove-Item 'checkpoints.zip'}"
    echo ✅ Wav2Lip pronto
) else (
    echo ✅ Wav2Lip já existe
)

cd ..
echo.

REM Criar arquivo example.py
echo 📝 Criando exemplo de uso...

(
echo # -*- coding: utf-8 -*-
echo """
echo Exemplo simples - execute assim:
echo     python example.py
echo """
echo.
echo import sys
echo import os
echo sys.path.insert(0, os.path.dirname(__file__^^)
echo.
echo from avatar_video_processor import AvatarVideoProducer
echo.
echo # ============================================================
echo # ⚙️ CONFIGURAR AQUI
echo # ============================================================
echo.
echo # Seu script (o que o avatar vai falar^)
echo SCRIPT = """
echo Olá! Bem-vindo ao Avatar Video Producer.
echo Sou um avatar de inteligência artificial.
echo Posso falar e criar vídeos em segundos!
echo Tudo 100%% grátis e open-source.
echo Vamos produzir conteúdo incrível juntos!
echo """.strip(^)
echo.
echo # Caminho da imagem do avatar
echo AVATAR_IMAGE = "inputs/avatar.jpg"
echo.
echo # Caminho do vídeo de saída
echo OUTPUT_VIDEO = "outputs/video_resultado.mp4"
echo.
echo # ============================================================
echo # 🚀 EXECUTAR
echo # ============================================================
echo.
echo if __name__ == "__main__":
echo     
echo     if not os.path.exists(AVATAR_IMAGE^):
echo         print(f"❌ Erro: Imagem não encontrada: {AVATAR_IMAGE}"^)
echo         print(""^)
echo         print("👉 Passos:"^)
echo         print("   1. Coloque sua imagem em 'inputs/'"^)
echo         print("   2. Renomeie para 'avatar.jpg'"^)
echo         print("   3. Execute novamente"^)
echo         sys.exit(1^)
echo     
echo     print("="*60^)
echo     print("🎬 AVATAR VIDEO PRODUCER"^)
echo     print("="*60^)
echo     print(""^)
echo     
echo     producer = AvatarVideoProducer(work_dir="."^)
echo     
echo     success = producer.produce(
echo         text=SCRIPT,
echo         avatar_image_path=AVATAR_IMAGE,
echo         output_path=OUTPUT_VIDEO,
echo         duration_max=10
echo     ^)
echo     
echo     if success:
echo         print(""^)
echo         print("="*60^)
echo         print("✅ VÍDEO GERADO COM SUCESSO!"^)
echo         print("="*60^)
echo         print(f"📁 Arquivo: {OUTPUT_VIDEO}"^)
echo         size_mb = os.path.getsize(OUTPUT_VIDEO^) / ^(1024*1024^)
echo         print(f"📊 Tamanho: {size_mb:.1f}MB"^)
echo         print(""^)
echo         print("📺 Abra no Windows Media Player ou VLC"^)
echo     else:
echo         print("❌ Algo deu errado"^)
echo         sys.exit(1^)
) > example.py

echo ✅ Exemplo criado: example.py
echo.

REM Criar START_HERE.md
echo 📖 Criando guia rápido...

(
echo # 🎬 AVATAR VIDEO PRODUCER - INÍCIO RÁPIDO
echo.
echo ## ✅ Instalação Completa!
echo.
echo Tudo foi instalado automaticamente. Agora você pode:
echo.
echo ---
echo.
echo ## 🚀 USAR EM 3 PASSOS:
echo.
echo ### 1️⃣ Colocar Imagem do Avatar
echo - Coloque sua foto (PNG ou JPG) na pasta **inputs/**
echo - Renomeie para **avatar.jpg**
echo - Ideal: rosto claro, bem iluminado
echo.
echo ### 2️⃣ Editar o Script
echo - Abra o arquivo: **example.py**
echo - Altere o texto em `SCRIPT = """..."""`
echo - Máximo ~50 palavras (10 segundos^)
echo.
echo ### 3️⃣ Executar
echo.
echo **Opção A: Duplo clique**
echo 1. Copie este arquivo em avatar-producer:
echo.
echo ```
echo @echo off
echo python example.py
echo pause
echo ```
echo.
echo 2. Salve como: **run.bat**
echo 3. Duplo clique em **run.bat**
echo.
echo **Opção B: Terminal**
echo 1. Abra PowerShell em avatar-producer
echo 2. Digite: `python example.py`
echo 3. Aguarde 1-3 minutos
echo.
echo ---
echo.
echo ## 📁 Resultado
echo.
echo Seu vídeo estará em:
echo ```
echo outputs/video_resultado.mp4
echo ```
echo.
echo ---
echo.
echo ## 📁 Estrutura de Pastas
echo.
echo ```
echo avatar-producer/
echo ├── inputs/              ← Coloque avatar.jpg aqui
echo ├── outputs/             ← Vídeos ficam aqui
echo ├── models/              ← Modelos IA
echo ├── example.py           ← Execute este
echo ├── avatar_video_processor.py
echo └── START_HERE.md        ← Este arquivo
echo ```
echo.
echo ---
echo.
echo ## ⏱️ Tempo
echo.
echo - **Primeira vez**: 5-10 minutos ^(downloads^)
echo - **Próximas vezes**: 1-3 minutos
echo.
echo ---
echo.
echo ## ⚠️ Problemas Comuns
echo.
echo ### Erro: "ModuleNotFoundError"
echo → Instale novamente: `pip install -r requirements.txt`
echo.
echo ### Erro: "Imagem não encontrada"
echo → Coloque a imagem em `inputs/avatar.jpg`
echo.
echo ### Muito lento
echo → Normal na primeira vez ^(downloads^)
echo.
echo ---
echo.
echo **Bom vídeo!** 🚀🎬
echo.
) > START_HERE.md

echo ✅ Guia criado: START_HERE.md
echo.

REM Script para executar fácil
echo 📝 Criando atalho de execução...

(
echo @echo off
echo REM Duplo clique para executar
echo python example.py
echo pause
) > run.bat

echo ✅ Atalho criado: run.bat (duplo clique para executar^)
echo.

REM Resumo final
echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║  ✅ INSTALAÇÃO CONCLUÍDA COM SUCESSO!                     ║
echo ╚════════════════════════════════════════════════════════════╝
echo.
echo 🎯 PRÓXIMOS PASSOS:
echo.
echo    1. Leia: START_HERE.md (nesta pasta^)
echo    2. Coloque sua imagem em: inputs\avatar.jpg
echo    3. Edite o script em: example.py
echo    4. Duplo clique em: run.bat
echo       OU
echo       Abra PowerShell e digite: python example.py
echo.
echo ⏱️  Tempo: 1-3 minutos para gerar seu primeiro vídeo
echo.
echo 📁 Pasta: %cd%
echo.
echo 🚀 Bom vídeo!
echo.
pause
