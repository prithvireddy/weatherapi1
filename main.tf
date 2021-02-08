provider "azurerm" {
  features {
    
  }
}

terraform {
  backend "azurerm" {
    resource_group_name     = "tf_rg_blobstore"
    storage_account_name    = "tfstorageaccountp"
    container_name          = "tfstate"
    key                     = "terraform.tfstate"
  }
}

resource "azurerm_resource_group" "tf_test" {
  name = "tfmainrg"
  location = "East US"
}

resource "azurerm_container_group" "tfcg_test" {
  name                = "weatherapi"
  location            = azurerm_resource_group.tf_test.location
  resource_group_name = azurerm_resource_group.tf_test.name

  ip_address_type = "public"
  dns_name_label = "weatherapidns"
  os_type = "Linux"

  container {
    name = "weatherapi"
    image = "prithvireddy9/dotnetsample:${var.imagebuild}"
    cpu =  "1"
    memory = "1"

    ports {
      port = 80
      protocol = "TCP"
    }
  }
}
