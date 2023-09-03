package main

import (
	"context"
	"fmt"

	"github.com/NicklasWallgren/ewelink"
	"github.com/eufelipemateus/sonoff-bottao-background/utils"
	"github.com/gen2brain/beeep"

	config "github.com/eufelipemateus/sonoff-bottao-background/config"
	hook "github.com/robotn/gohook"
)

func main() {
	println("Starting...")

	err := config.Load()
	if err != nil {
		panic("Erro on load config.toml")
	}

	instance := ewelink.New()

	session, err := instance.AuthenticateWithEmail(
		context.Background(),
		ewelink.NewConfiguration(
			"eu",
			ewelink.WithAppID(config.GetAppId()),
			ewelink.WithAppSecret(config.GetAppSecrert()),
		),
		config.GetEmail(),
		config.GetPassword(),
	)
	utils.Check(err)

	hook.Register(hook.KeyDown, []string{"ctrl", "alt", "num0"}, func(e hook.Event) {
		devices, err := instance.GetDevices(context.Background(), session)
		utils.Check(err)
		light, message := toogleLight(devices)
		_, err = instance.SetDevicePowerState(
			context.Background(),
			session,
			&devices.Devicelist[0],
			light,
		)
		utils.Check(err)
		fmt.Printf("[Status] %s \n", message)
		err = beeep.Notify("Status da Lampada", message, "light.ico")
		utils.Check(err)
	})

	s := hook.Start()
	<-hook.Process(s)
}

func toogleLight(devices *ewelink.DevicesResponse) (bool, string) {
	var light bool
	var message string
	if devices.Devicelist[0].Params.Switch == "on" {
		light = false
		message = "Lampada Apagada!!"
		return light, message
	} else {
		light = true
		message = "Lampada Ligada!!"
		return light, message
	}
}
