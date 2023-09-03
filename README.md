# sonoff-bottao-background

Este projeto é versão 2 do projeto  [sonoff-botao](https://github.com/eufelipemateus/sonoff-botao) que permite controlar a luz do comodo com tecla do computador.

Existe algumas diferenças desse projeto pro outro o primeiro é linguagem agora esta usando golang, segundo agora ele funciona como serviço executanto em segundo plano.

## Instalação

Esse projeto foi feito pra rodar em sistema operacional linux 64 existe 4 arquivos que funcionam importantes que precisam estar em pastas paras funcionar corretamete.

 1. **sonoff.sh**
  Esse arquivo precisa esta em ```/etc/sonoff/sonoff.sh```
 2. **sonoff.service**
 Este arquivo precisa esta em```/etc/systemd/user/sonoff.service```
 3. **config.toml**
 Este é orquivo de configuração que tera os dados de acesso ao ewelink precisa esta em  ``` /etc/sonoff/config.toml ```
 4. **light.ico**
 Este é o icone que ira aparece na notificaçao da alteração status precisa esta em  ```/etc/sonoff/light.ico```
 5. **dist/sonoff**
 Este arquivo precisa esta em  ``` /usr/local/bin/sonoff ```

É possivel fazer instalção desses arquivos nos lugares corretos fazendo a execução do comando:

 ```bash
 make install 
 ```

## Como Funciona?

Este programa é um serviço que funciona em segundo plano ele mantem uma sessão sempre ativa com [ewelink.cc](ewelink.cc) execudando bem mais rapido que projeto anterior, além de ficar escutando as teclas ctrl + alt + num0 quando essas teclas foram pressinadas juntas o software é ativado enviando uma requisição para [ewelink.cc](ewelink.cc) ligando/desligando a luz.

## Referencias

- [gohook](github.com/robotn/gohook)
- [beeep](github.com/gen2brain/beeep)
- [ewelink](github.com/NicklasWallgren/ewelink)

## Autor

[Felipe Mateus](https://felipemateus.com)
