provider "azurerm" {
  features {
    
  }
}

resource "azurerm_resource_group" "tf_test" {
  name = "tfmainrg"
  location = "Australia East"
}

resource "azurerm_container_group" "tfcg_test" {
  name      =  "weatherapi"
  location  =   azurerm_resource_group.tf_test.location
  resource_group_name = azurerm_resource_group.tf_test.name

  ip_address_type = "public"
  dns_name_label = "weatherapi"
  os_type = "Linux"

  container {
    name   = "weatherapi"
    image  = "prithvireddy9/dotnetsample:latest"
    cpu    = "0.5"
    memory = "1"
  
    ports {
      port     = 80
      protocol = "TCP"
        }
  }
}