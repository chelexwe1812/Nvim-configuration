# Nvim-configuration
Mi configuración personal para trabajar con nvim y php
# Configuración de Neovim en macOS

Este README detalla los pasos para configurar Neovim en macOS utilizando Homebrew.
## Prerrequisitos

Asegúrate de tener Homebrew instalado en tu sistema. Si no lo tienes, puedes instalarlo siguiendo las instrucciones en [[brew.sh](https://brew.sh/)](https://brew.sh).

## Instalación de Neovim

1. **Instalar Neovim:**

   Ejecuta el siguiente comando para instalar Neovim usando Homebrew:

   ```bash
   brew install neovim

2. **Crea los archivos necesarios:**

   Ejecuta el siguiente comando para crear los archivos necesarios para neovim:

   ```bash
   mkdir -p ~/.config/nvim
   touch ~/.config/nvim/init.lua

3. **Instalar Packer:**

   Ejecuta el siguiente comando para clonar el repositorio de packer dentro de la carpeta nvim/:

   ```bash
   git clone git@github.com:wbthomason/packer.nvim.git

4. **Abre el archivo .lua:**

   Utiliza el siguiente comando para abrir tu archivo init.lua:

   ```bash
   ~/.config/nvim/init.lua

5. **Configurar el archivo .lua:**

   utiliza el siguiente comando para abrir tu archivo init.lua:

   ```bash
   ~/.config/nvim/init.lua
