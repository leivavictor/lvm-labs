package main

import (
	"fmt"

	"github.com/pulumi/pulumi-azure-native/sdk/go/azure/network"
	"github.com/pulumi/pulumi/sdk/v3/go/pulumi"
)

func main() {
	pulumi.Run(func(ctx *pulumi.Context) error {

		nombreIP := "kubernetes-a68b578d169004729a7b82b6e28dea27"
		resourceGroupName := "aks01_resources"

		publicIP, err := network.LookupPublicIPAddress(ctx, &network.LookupPublicIPAddressArgs{
			PublicIpAddressName: nombreIP,
			ResourceGroupName:   resourceGroupName,
		})
		if err != nil {
			return fmt.Errorf("error getting the ip: %v", err)
		}

		ctx.Export("Response", pulumi.String(*publicIP.Id))
		return nil
	})
}
