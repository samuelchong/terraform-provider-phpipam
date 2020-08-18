package main

import (
"github.com/hashicorp/terraform-plugin-sdk/plugin"
"github.com/phpipam/terraform-provider-phpipam/plugin/providers/phpipam"
)

func main() {
	plugin.Serve(&plugin.ServeOpts{
		ProviderFunc: phpipam.Provider,
	})
}
