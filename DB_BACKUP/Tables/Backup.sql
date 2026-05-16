CREATE TABLE [dbo].[activeUser]
(
    [userId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [accessToken] NVARCHAR(255),
    [refreshToken] NVARCHAR(255),
    [loginAt] DATETIME,
    [createdAt] DATETIME,
    [updatedAt] DATETIME
);

CREATE TABLE [dbo].[admin]
(
    [adminId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [adminName] NVARCHAR(255),
    [email] NVARCHAR(255) UNIQUE,
    [mobile] NVARCHAR(255),
    [password] NVARCHAR(255),
    [securityQuestion] NVARCHAR(255),
    [securityAnswer] NVARCHAR(255),
    [createdDate] DATETIME,
    [modifiedDate] DATETIME,
    [isActive] BIT
);

CREATE TABLE [dbo].[customerPayment]
(
    [paymentId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [settlementId] UNIQUEIDENTIFIER,
    [customerId] UNIQUEIDENTIFIER,
    [tableId] UNIQUEIDENTIFIER,
    [paidAmount] DECIMAL(18,4),
    [instrumentId] UNIQUEIDENTIFIER,
    [paymentReceiptNo] NVARCHAR(50),
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[invoiceDetails]
(
    [invoiceDetailId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [invoiceId] UNIQUEIDENTIFIER,
    [invoiceNumber] NVARCHAR(50),
    [itemId] UNIQUEIDENTIFIER,
    [parentItemId] UNIQUEIDENTIFIER,
    [itemSizeId] UNIQUEIDENTIFIER,
    [itemQty] INT,
    [itemRate] DECIMAL(18,4),
    [subTotal] DECIMAL(18,4),
    [taxAmount] DECIMAL(18,4),
    [netAmount] DECIMAL(18,4),
    [roundOff] DECIMAL(18,4),
    [discount] DECIMAL(18,4),
    [specialDiscount] DECIMAL(18,4),
    [remarks] NVARCHAR(200),
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[invoiceHeader]
(
    [invoiceId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [outletId] UNIQUEIDENTIFIER,
    [invoiceNumber] NVARCHAR(50),
    [billedBy] UNIQUEIDENTIFIER,
    [tableId] UNIQUEIDENTIFIER,
    [tablePax] INT,
    [finYear] NVARCHAR(50),
    [businessSourceId] UNIQUEIDENTIFIER,
    [invoiceDate] DATETIME,
    [subTotal] DECIMAL(18,4),
    [taxAmount] DECIMAL(18,4),
    [netAmount] DECIMAL(18,4),
    [roundOff] DECIMAL(18,4),
    [discount] DECIMAL(18,4),
    [specialDiscount] DECIMAL(18,4),
    [customerId] UNIQUEIDENTIFIER,
    [isSettled] BIT,
    [settledBy] UNIQUEIDENTIFIER,
    [remarks] NVARCHAR(200),
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[m_businessSource]
(
    [businessSourceId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [businessSourceName] NVARCHAR(100),
    [channelId] UNIQUEIDENTIFIER,
    [commisionPercentage] DECIMAL(18,4),
    [contactPersonName] NVARCHAR(50),
    [contactPersonPhoneNo] NVARCHAR(50),
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[m_channel]
(
    [channelId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [channelName] NVARCHAR(50),
    [GSTNo] NVARCHAR(50),
    [PANNo] NVARCHAR(50),
    [FSSAINo] NVARCHAR(50),
    [address] NVARCHAR(200),
    [stateId] UNIQUEIDENTIFIER,
    [countryId] UNIQUEIDENTIFIER,
    [districtId] UNIQUEIDENTIFIER,
    [phoneNo] NVARCHAR(50),
    [emailId] NVARCHAR(50),
    [website] NVARCHAR(50),
    [defaultCustomerId] UNIQUEIDENTIFIER,
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[m_city]
(
    [cityId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [cityName] NVARCHAR(50),
    [channelId] UNIQUEIDENTIFIER,
    [stateId] UNIQUEIDENTIFIER,
    [countryId] UNIQUEIDENTIFIER,
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[m_company]
(
    [companyId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [companyName] NVARCHAR(200),
    [address] NVARCHAR(200),
    [stateId] UNIQUEIDENTIFIER,
    [phoneNo] NVARCHAR(50),
    [emailId] NVARCHAR(50),
    [GSTNo] NVARCHAR(50),
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[m_country]
(
    [countryId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [countryName] NVARCHAR(50),
    [channelId] UNIQUEIDENTIFIER,
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[m_customer]
(
    [customerId] UNIQUEIDENTIFIER,
    [customerName] NVARCHAR(50),
    [channelId] UNIQUEIDENTIFIER,
    [companyId] UNIQUEIDENTIFIER,
    [gender] NVARCHAR(50),
    [religion] NVARCHAR(50),
    [phoneNo] NVARCHAR(50),
    [emailId] NVARCHAR(50),
    [GSTNo] NVARCHAR(50),
    [occupation] NVARCHAR(50),
    [language] NVARCHAR(50),
    [isDiscountAllow] BIT,
    [isCreditAllow] BIT,
    [creditLimit] DECIMAL(18,4),
    [isCustomerBlocked] BIT,
    [isCustomerVIP] BIT,
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[m_department]
(
    [departmentId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [departmentName] NVARCHAR(100),
    [shortCode] NVARCHAR(50),
    [channelId] UNIQUEIDENTIFIER,
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[m_employee]
(
    [employeeID] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [channelID] CHAR(36),
    [name] NVARCHAR(255),
    [email] NVARCHAR(255),
    [password] NVARCHAR(255),
    [mobile] NVARCHAR(255),
    [joiningDate] DATETIMEOFFSET(7),
    [resignDate] DATETIMEOFFSET(7),
    [deptId] CHAR(36),
    [empTypeId] CHAR(36),
    [empCode] NVARCHAR(255),
    [designation] NVARCHAR(255),
    [imageAddress] NVARCHAR(255),
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[m_employeeType]
(
    [employeeTypeId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [typeName] NVARCHAR(50),
    [shortCode] NVARCHAR(50),
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[m_facilityStatus]
(
    [facilityStatusId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [statusName] NVARCHAR(50),
    [channelId] UNIQUEIDENTIFIER,
    [prefix] NVARCHAR(50),
    [type] NVARCHAR(50),
    [color] NVARCHAR(50),
    [sequence] INT,
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[m_finYear]
(
    [finYearId] UNIQUEIDENTIFIER,
    [finYear] NVARCHAR(50),
    [channelId] UNIQUEIDENTIFIER,
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[m_instrument]
(
    [instrumentId] UNIQUEIDENTIFIER,
    [instrumentName] NVARCHAR(50),
    [channelId] UNIQUEIDENTIFIER,
    [shortCode] NVARCHAR(50),
    [iconName] NVARCHAR(50),
    [serialNo] INT,
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[m_item]
(
    [itemId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [itemName] NVARCHAR(50),
    [channelId] UNIQUEIDENTIFIER,
    [itemGroupId] UNIQUEIDENTIFIER,
    [itemCategoryId] UNIQUEIDENTIFIER,
    [itemTypeId] UNIQUEIDENTIFIER,
    [itemCode] NVARCHAR(50),
    [UOMId] UNIQUEIDENTIFIER,
    [HSNCode] NVARCHAR(50),
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[m_itemCategory]
(
    [itemCategoryId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [categoryName] NVARCHAR(50),
    [channelId] UNIQUEIDENTIFIER,
    [itemGroupId] UNIQUEIDENTIFIER,
    [shortCode] NVARCHAR(50),
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[m_itemGroup]
(
    [itemGroupId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [groupName] NVARCHAR(50),
    [channelId] UNIQUEIDENTIFIER,
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[m_itemSize]
(
    [itemSizeId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [sizeName] NVARCHAR(50),
    [channelId] UNIQUEIDENTIFIER,
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[m_itemType]
(
    [itemTypeId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [typeName] NVARCHAR(50),
    [prefix] NVARCHAR(50),
    [channelId] UNIQUEIDENTIFIER,
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[m_menu]
(
    [menuId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [menuName] NVARCHAR(50),
    [menuIcon] NVARCHAR(50),
    [isActive] BIT,
    [type] VARCHAR(100)
);

CREATE TABLE [dbo].[m_menuAction]
(
    [actionId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [menuId] UNIQUEIDENTIFIER,
    [actionName] NVARCHAR(50),
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[m_outlet]
(
    [outletId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [outletName] NVARCHAR(50),
    [outletCode] NVARCHAR(50),
    [deptId] UNIQUEIDENTIFIER,
    [channelId] UNIQUEIDENTIFIER,
    [phoneNo] NVARCHAR(50),
    [emailId] NVARCHAR(50),
    [billPrefix] NVARCHAR(50),
    [defaultPayModeId] UNIQUEIDENTIFIER,
    [address] NVARCHAR(200),
    [taxAfterDiscount] BIT,
    [servChargeAfterDiscount] BIT,
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[m_section]
(
    [sectionId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [sectionName] NVARCHAR(50),
    [outletId] UNIQUEIDENTIFIER,
    [serial] INT,
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[m_serviceCharge]
(
    [serviceChargeId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [chargeName] NVARCHAR(50),
    [percentage] DECIMAL(18,4),
    [outletId] UNIQUEIDENTIFIER,
    [channelId] UNIQUEIDENTIFIER,
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[m_settlement]
(
    [settlementId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [channelId] UNIQUEIDENTIFIER,
    [settlementDate] DATETIME,
    [outletId] UNIQUEIDENTIFIER,
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[m_state]
(
    [stateId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [stateName] NVARCHAR(50),
    [countryId] UNIQUEIDENTIFIER,
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[m_table]
(
    [tableId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [tableName] NCHAR(10),
    [outletId] UNIQUEIDENTIFIER,
    [sectionId] UNIQUEIDENTIFIER,
    [capacity] INT,
    [addonCapacity] INT,
    [serial] INT,
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[m_tax]
(
    [taxId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [taxName] NVARCHAR(50),
    [taxRate] DECIMAL(18,4),
    [fromAmount] DECIMAL(18,4),
    [toAmount] DECIMAL(18,4),
    [restrictedFrom] DECIMAL(18,4),
    [restrictedTo] DECIMAL(18,4),
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[m_uom]
(
    [uomId] UNIQUEIDENTIFIER,
    [uomName] NVARCHAR(50),
    [channelId] UNIQUEIDENTIFIER,
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[map_dayclose]
(
    [daycloseId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [outletId] UNIQUEIDENTIFIER,
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[map_itemServiceCharge]
(
    [itemServiceChargeMapId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [itemId] UNIQUEIDENTIFIER,
    [serviceChargeId] UNIQUEIDENTIFIER,
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[map_outletTax]
(
    [outletTaxId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [itemId] UNIQUEIDENTIFIER,
    [itemSizeId] UNIQUEIDENTIFIER,
    [taxId] UNIQUEIDENTIFIER,
    [channelId] UNIQUEIDENTIFIER,
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[map_tableLog]
(
    [tableLogId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [tableId] UNIQUEIDENTIFIER,
    [outletId] UNIQUEIDENTIFIER,
    [capacity] INT,
    [pax] INT,
    [serial] INT,
    [invoiceNumber] NVARCHAR(50),
    [sectionId] UNIQUEIDENTIFIER,
    [tableName] NVARCHAR(50),
    [customerId] UNIQUEIDENTIFIER,
    [tableType] NVARCHAR(50),
    [isOpenTable] BIT,
    [facilityStatusId] UNIQUEIDENTIFIER,
    [isVIP] BIT,
    [prefix] NVARCHAR(50),
    [subTotal] DECIMAL(18,4),
    [netAmount] DECIMAL(18,4),
    [remarks] NVARCHAR(200),
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[map_userAction]
(
    [userActionMapId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [userMenuMapId] UNIQUEIDENTIFIER NOT NULL,
    [actionId] UNIQUEIDENTIFIER,
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[map_userChannel]
(
    [userChannelMapId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [userId] UNIQUEIDENTIFIER,
    [channelId] UNIQUEIDENTIFIER,
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[map_userMenu]
(
    [userMenuMapId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [userId] UNIQUEIDENTIFIER,
    [meuId] UNIQUEIDENTIFIER,
    [outletId] UNIQUEIDENTIFIER,
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[orderDetails]
(
    [orderDetailsId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [orderId] UNIQUEIDENTIFIER,
    [itemId] UNIQUEIDENTIFIER,
    [itemSizeId] UNIQUEIDENTIFIER,
    [itemQty] INT,
    [subTotal] DECIMAL(18,4),
    [taxAmount] DECIMAL(18,4),
    [netAmount] DECIMAL(18,4),
    [isNCItem] BIT,
    [NCItemRemarks] NVARCHAR(200),
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[orderHeader]
(
    [orderId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [outletId] UNIQUEIDENTIFIER,
    [tableId] UNIQUEIDENTIFIER,
    [kotNumber] NVARCHAR(50),
    [pax] INT,
    [orderDate] DATETIME,
    [orderTaker] UNIQUEIDENTIFIER,
    [orderRemarks] NVARCHAR(200),
    [subTotal] DECIMAL(18,4),
    [taxAmount] DECIMAL(18,4),
    [netAmount] DECIMAL(18,4),
    [customerId] UNIQUEIDENTIFIER,
    [isIgstEnable] BIT,
    [isVIP] BIT,
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);

CREATE TABLE [dbo].[paymentAdjustment]
(
    [adjustmentId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [paymentId] UNIQUEIDENTIFIER,
    [settlementId] UNIQUEIDENTIFIER,
    [invoiceId] UNIQUEIDENTIFIER,
    [paidAmount] DECIMAL(18,4),
    [dueAmount] DECIMAL(18,4),
    [payMode] NVARCHAR(50),
    [createdDate] DATETIME,
    [createdBy] UNIQUEIDENTIFIER,
    [modifiedDate] DATETIME,
    [modifiedBy] UNIQUEIDENTIFIER,
    [isActive] BIT
);