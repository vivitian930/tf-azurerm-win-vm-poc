resource "azurerm_virtual_network" "this" {
  count               = var.existing_subnet_id == "" ? 1 : 0
  name                = "vnet-${var.name}-01"
  address_space       = var.vnet_addresses
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "this" {
  count                = var.existing_subnet_id == "" ? 1 : 0
  name                 = "internal"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_network_network.this[0].name
  address_prefixes     = var.subnet_cidr
}
