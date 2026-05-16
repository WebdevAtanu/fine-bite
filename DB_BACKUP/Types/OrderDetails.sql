CREATE TYPE [dbo].[orderDetailsType] AS TABLE(
    [orderId] [uniqueidentifier] NULL,
    [itemId] [uniqueidentifier] NULL,
    [itemSizeId] [uniqueidentifier] NULL,
    [itemQty] [int] NULL,
    [price] [decimal](18, 2) NULL,
    [isNcItem] [bit] NULL,
    [ncItemRemarks] [varchar](255) NULL
)