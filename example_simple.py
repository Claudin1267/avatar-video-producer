#!/usr/bin/env python3
"""
Exemplo simples de uso (local ou Colab)
"""

from avatar_video_processor import AvatarVideoProducer

# Inicializar
producer = AvatarVideoProducer(work_dir="./")

# Script do avatar
script = """
Olá! Bem-vindo ao Avatar Video Producer.
Sou um avatar de IA.
Posso falar em vídeos de até 10 segundos.
Tudo 100% grátis!
""".strip()

# Gerar vídeo
success = producer.produce(
    text=script,
    avatar_image_path="inputs/avatar.jpg",  # Sua imagem aqui
    output_path="outputs/video_resultado.mp4",
    duration_max=10
)

if success:
    print("\n✅ Vídeo gerado com sucesso!")
    print("   📁 outputs/video_resultado.mp4")
else:
    print("\n❌ Erro na geração")
