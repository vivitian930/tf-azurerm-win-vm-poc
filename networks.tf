resource "azurerm_virtual_network" "this" {
  count               = var.existing_subnet_id == "" ? 1 : 0
  name                = "vnet-${var.name}-01"
  address_space       = var.vnet_addresses
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "this" {
  count                = var.existing_subnet_id == "" ? 1 : 0
  name                 = "internal"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this[0].name
  address_prefixes     = var.subnet_cidr
}
