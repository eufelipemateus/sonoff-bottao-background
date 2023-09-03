package config

import (
	"github.com/spf13/viper"
)

var cfg *config

type config struct {
	Access access
}

type access struct {
	Email     string
	Password  string
	AppId     string
	AppSecret string
}

func init() {

}

func Load() error {
	viper.SetConfigName("config")
	viper.SetConfigType("toml")
	viper.AddConfigPath(".")

	err := viper.ReadInConfig()

	if err != nil {
		if _, ok := err.(viper.ConfigFileNotFoundError); !ok {
			return err
		}
	}

	cfg = new(config)
	cfg.Access = access{
		Email:     viper.GetString("email"),
		Password:  viper.GetString("password"),
		AppSecret: viper.GetString("app_secret"),
		AppId:     viper.GetString("app_id"),
	}

	return nil
}

func GetEmail() string {
	return cfg.Access.Email
}

func GetPassword() string {
	return cfg.Access.Password
}

func GetAppSecrert() string {
	return cfg.Access.AppSecret
}

func GetAppId() string {
	return cfg.Access.AppId
}
