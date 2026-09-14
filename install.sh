#!/bin/bash
# 🎬 AVATAR VIDEO PRODUCER - INSTALADOR COMPLETO
# Execute este arquivo para instalar tudo automaticamente
# Uso: bash install.sh

set -e  # Para se houver erro

echo "╔════════════════════════════════════════════════════════════╗"
echo "║  🎬 AVATAR VIDEO PRODUCER - INSTALADOR AUTOMÁTICO         ║"
echo "║  Produz vídeos com avatar falando (até 10s)                ║"
echo "║  100% GRÁTIS                                               ║"
echo "╚════════════════════════════════════════════════════════════╝"

echo ""
echo "⚠️  REQUISITOS:"
echo "   • Python 3.8+ instalado"
echo "   • 5GB de espaço livre"
echo "   • Conexão internet (para downloads)"
echo ""

# Verificar Python
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 não encontrado!"
    echo "   Instale em: https://www.python.org/downloads/"
    exit 1
fi

PYTHON_VERSION=$(python3 --version 2>&1 | awk '{print $2}')
echo "✅ Python $PYTHON_VERSION encontrado"

# Criar diretórios
echo ""
echo "📁 Criando diretórios..."
mkdir -p avatar-producer/{inputs,outputs,models,temp,audio}
cd avatar-producer

# Atualizar pip
echo ""
echo "📦 Atualizando pip..."
python3 -m pip install --upgrade pip -q

# Instalar dependências
echo ""
echo "📥 Instalando dependências Python..."
echo "   (isso pode levar 5-10 minutos)"

pip install -q \
    numpy==1.24.3 \
    scipy>=1.10.0 \
    scikit-image>=0.21.0 \
    opencv-python>=4.8.0 \
    Pillow>=10.0.0 \
    imageio>=2.31.0 \
    librosa>=0.10.0 \
    soundfile>=0.12.0 \
    torch>=2.0.0 \
    torchvision>=0.15.0 \
    torchaudio>=2.0.0 \
    requests>=2.31.0 \
    pydub>=0.25.1 \
    pexpect>=4.8.0 \
    mediapipe>=0.10.0 \
    gdown>=4.7.0

echo "✅ Dependências instaladas!"

# Verificar FFmpeg
echo ""
echo "🎬 Verificando FFmpeg..."
if ! command -v ffmpeg &> /dev/null; then
    echo "⚠️  FFmpeg não encontrado!"
    echo ""
    echo "   Instale manualmente:"
    echo ""
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "   Linux: sudo apt install ffmpeg"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "   macOS: brew install ffmpeg"
    elif [[ "$OSTYPE" == "msys" ]]; then
        echo "   Windows: https://ffmpeg.org/download.html"
    fi
    echo ""
else
    FFMPEG_VERSION=$(ffmpeg -version 2>&1 | head -n1)
    echo "✅ $FFMPEG_VERSION"
fi

# Download modelos
echo ""
echo "🤖 Baixando modelos pré-treinados..."
echo "   Wav2Lip Checkpoints (240MB)..."

cd models

if [ ! -f "checkpoints/wav2lip.pth" ]; then
    wget -q --show-progress https://github.com/justinjohn0306/Wav2Lip/releases/download/v1.0/checkpoints.zip
    unzip -q checkpoints.zip
    rm checkpoints.zip
    echo "✅ Wav2Lip pronto"
else
    echo "✅ Wav2Lip já existe"
fi

cd ..

# Criar exemplo
echo ""
echo "📝 Criando exemplo de uso..."

cat > example.py << 'EOF'
#!/usr/bin/env python3
"""
Exemplo simples - execute assim:
    python3 example.py
"""

import sys
import os
sys.path.insert(0, os.path.dirname(__file__))

from avatar_video_processor import AvatarVideoProducer

# ============================================================
# ⚙️ CONFIGURAR AQUI
# ============================================================

# Seu script (o que o avatar vai falar)
SCRIPT = """
Olá! Bem-vindo ao Avatar Video Producer.
Sou um avatar de inteligência artificial.
Posso falar e criar vídeos em segundos!
Tudo 100% grátis e open-source.
Vamos produzir conteúdo incrível juntos!
""".strip()

# Caminho da imagem do avatar (sua foto ou avatar)
AVATAR_IMAGE = "inputs/avatar.jpg"

# Caminho do vídeo de saída
OUTPUT_VIDEO = "outputs/video_resultado.mp4"

# ============================================================
# 🚀 EXECUTAR
# ============================================================

if __name__ == "__main__":
    
    # Verificar se imagem existe
    if not os.path.exists(AVATAR_IMAGE):
        print(f"❌ Erro: Imagem não encontrada: {AVATAR_IMAGE}")
        print("")
        print("👉 Passos:")
        print("   1. Coloque sua imagem (PNG ou JPG) na pasta 'inputs/'")
        print("   2. Renomeie para 'avatar.jpg' (ou edite AVATAR_IMAGE acima)")
        print("   3. Execute novamente")
        sys.exit(1)
    
    print("="*60)
    print("🎬 AVATAR VIDEO PRODUCER")
    print("="*60)
    print("")
    
    # Criar produtor
    producer = AvatarVideoProducer(work_dir=".")
    
    # Gerar vídeo
    success = producer.produce(
        text=SCRIPT,
        avatar_image_path=AVATAR_IMAGE,
        output_path=OUTPUT_VIDEO,
        duration_max=10
    )
    
    if success:
        print("")
        print("="*60)
        print("✅ VÍDEO GERADO COM SUCESSO!")
        print("="*60)
        print(f"📁 Arquivo: {OUTPUT_VIDEO}")
        
        # Mostrar tamanho
        size_mb = os.path.getsize(OUTPUT_VIDEO) / (1024*1024)
        print(f"📊 Tamanho: {size_mb:.1f}MB")
        
        print("")
        print("📺 Abra o arquivo no VLC ou Windows Media Player")
        print("📤 Compartilhe em YouTube, TikTok, Instagram, etc.")
    else:
        print("❌ Algo deu errado. Veja os logs acima.")
        sys.exit(1)
EOF

chmod +x example.py
echo "✅ Exemplo criado: example.py"

# Criar README de início rápido
echo ""
echo "📖 Criando guia rápido..."

cat > START_HERE.md << 'EOF'
# 🎬 AVATAR VIDEO PRODUCER - INÍCIO RÁPIDO

## ✅ Instalação Completa!

Tudo foi instalado automaticamente. Agora você pode:

---

## 🚀 USAR EM 3 PASSOS:

### 1️⃣ Colocar Imagem do Avatar
- Coloque sua foto (PNG ou JPG) na pasta **inputs/**
- Renomeie para **avatar.jpg**
- Ideal: rosto claro, bem iluminado, sem sombras

### 2️⃣ Editar o Script
- Abra o arquivo: **example.py**
- Altere o texto no `SCRIPT = """..."""`
- Escreva o que você quer que o avatar fale
- Máximo ~50 palavras (10 segundos)

### 3️⃣ Executar
No terminal/PowerShell, navegue até essa pasta e execute:

```bash
python3 example.py
```

Aguarde 1-3 minutos... ✨

---

## 📁 Resultado

Seu vídeo estará em:
```
outputs/video_resultado.mp4
```

---

## 🎯 Exemplo Completo

### Arquivo: example.py

```python
SCRIPT = """
Olá! Eu sou um avatar de IA.
Posso falar em vídeos de até 10 segundos.
Tudo é 100% grátis!
Vamos criar conteúdo juntos.
"""

AVATAR_IMAGE = "inputs/avatar.jpg"
OUTPUT_VIDEO = "outputs/meu_video.mp4"
```

Depois execute:
```bash
python3 example.py
```

---

## ⏱️ Tempo

- **Primeira vez**: 5-10 minutos (downloads)
- **Próximas vezes**: 1-3 minutos

---

## 🛠️ Estrutura de Pastas

```
avatar-producer/
├── inputs/              ← Coloque sua imagem aqui
├── outputs/             ← Vídeos ficam aqui
├── models/              ← Modelos IA (já baixados)
├── example.py           ← Execute este arquivo
├── avatar_video_processor.py   ← Engine
└── START_HERE.md        ← Este arquivo
```

---

## 📸 Imagem Ideal

✅ BOM:
- Rosto bem centralizado
- Iluminação frontal
- Fundo claro/simples
- Câmera frontal

❌ EVITAR:
- De perfil
- Muito escuro
- Várias pessoas
- Muito zoom/longe

---

## ⚠️ Problemas Comuns

### "ModuleNotFoundError"
→ Reinstale: `pip install -r requirements.txt`

### "Imagem não encontrada"
→ Coloque a imagem em `inputs/` e renomeie para `avatar.jpg`

### "Muito lento"
→ Normal na primeira vez (download de modelos)

### "CUDA error"
→ Sistema usa CPU automaticamente

---

## 🎬 Próximos Passos

1. Personalize o script em `example.py`
2. Execute `python3 example.py`
3. Assista o vídeo em `outputs/video_resultado.mp4`
4. Compartilhe nas redes sociais!

---

## 🔗 Links Úteis

- [Gerador de Avatares](https://thispersondoesnotexist.com)
- [GitHub](https://github.com/Claudin1267/avatar-video-producer)
- [Documentação](../README.md)

---

**Bom vídeo!** 🚀🎬

Criado com ❤️ para democratizar criação de conteúdo
EOF

echo "✅ Guia criado: START_HERE.md"

# Resumo final
echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║  ✅ INSTALAÇÃO CONCLUÍDA COM SUCESSO!                     ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "🎯 PRÓXIMOS PASSOS:"
echo ""
echo "   1. Abra: START_HERE.md (nesta pasta)"
echo "   2. Leia as instruções"
echo "   3. Coloque sua imagem em: inputs/avatar.jpg"
echo "   4. Edite o script em: example.py"
echo "   5. Execute: python3 example.py"
echo ""
echo "⏱️  Tempo: 1-3 minutos para gerar seu primeiro vídeo"
echo ""
echo "📁 Pasta: $(pwd)"
echo ""
echo "🚀 Bom vídeo!"
echo ""
