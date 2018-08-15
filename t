@isTest
private class ProductTableControllerTest {

    @isTest static void testProductsSize(){
        
        Product_Table__c productProductsSize = new Product_Table__c();
        productProductsSize.Name = 'Iphone x';
        productProductsSize.Product_Description__c = 'Description X Description X Description X Description X Description X Description X Description X Description X Description X Description X Description X Description X Description X Description X';
        productProductsSize.Title__c = 'Title X';
        productProductsSize.Unit_Price__c = 1000.00;
        productProductsSize.Units_Available__c = 20;
        insert productProductsSize;
        
        ProductTableController controllerProductsSize = new ProductTableController();
        controllerProductsSize.closeErrorDisplay();
        controllerProductsSize.closeIsInsertDisplay();
               
        System.assert(controllerProductsSize.products.size() > 0);
        System.assert(!controllerProductsSize.isErrorDisplay);
        System.assert(!controllerProductsSize.isInsertDisplay);
        
    }
    
    
    @isTest static void testCalculateTotalAmount(){
        
        ProductTableController controllerCalculateTotalAmount = new ProductTableController();
        controllerCalculateTotalAmount.oneUnitPrice = 900.00;
        controllerCalculateTotalAmount.multiplier = 5;
        Decimal a = 4500.00;
        controllerCalculateTotalAmount.calculateTotalAmount();
        
        System.assertEquals(a, controllerCalculateTotalAmount.TotalAmount);
        
    }
    
    
    @isTest static void testCheckDisabledButtonFalse(){
        
        ProductTableController controllerCheckDisabledButtonFalse = new ProductTableController();
        controllerCheckDisabledButtonFalse.getContactInformation();
        controllerCheckDisabledButtonFalse.contactFieldAfterInsert.Email = 'smith@gmail.com';
        controllerCheckDisabledButtonFalse.contactFieldAfterInsert.LastName = 'Smith';
        controllerCheckDisabledButtonFalse.multiplier = 2;
        controllerCheckDisabledButtonFalse.checkDisabledButton();        
        Boolean booleanTestFalse = false;
        
        System.assertEquals(booleanTestFalse, controllerCheckDisabledButtonFalse.disabledButton);
      
    }
    
    
    @isTest static void testCheckDisabledButtonTrue(){
        
        ProductTableController controllerCheckDisabledButtonTrue = new ProductTableController();
        controllerCheckDisabledButtonTrue.getContactInformation();
        controllerCheckDisabledButtonTrue.contactFieldAfterInsert.Email = 'smith@gmail.com';
        controllerCheckDisabledButtonTrue.contactFieldAfterInsert.LastName = 'Smith';
        controllerCheckDisabledButtonTrue.multiplier = 0;
        controllerCheckDisabledButtonTrue.checkDisabledButton();
        Boolean booleanTestTrue = true;
        
        System.assertEquals(booleanTestTrue, controllerCheckDisabledButtonTrue.disabledButton);
        
    }
    
    
    @isTest static void testProductViewDetail(){
	
        Product_Table__c productTableRecordViewDetail = new Product_Table__c();
        productTableRecordViewDetail.Name = 'Samsung';
        productTableRecordViewDetail.Unit_Price__c = 700.00;
        productTableRecordViewDetail.Product_Description__c = 'Samsung Samsung Samsung';
        insert productTableRecordViewDetail;
        
        ProductTableController controllerProductViewDetail = new ProductTableController();
        
        PageReference pageReferenceViewDetail = Page.ProductDetailPage;
		pageReferenceViewDetail.getParameters().put('id', productTableRecordViewDetail.id);
		Test.setCurrentPage(pageReferenceViewDetail);
  		
        controllerProductViewDetail.getProductViewDetail();
        
        System.assertEquals(productTableRecordViewDetail, controllerProductViewDetail.productView);
        
    }
    
    
    @isTest static void testGetContactInformation(){
        
        ProductTableController controllerGetContactInformation = new ProductTableController();
        controllerGetContactInformation.getContactInformation();        
        Contact contactIsEmpty = new Contact();
        
        System.assertEquals(contactIsEmpty, controllerGetContactInformation.contactFieldAfterInsert);
        
    }
    
    
    @isTest static void TestUnitsAvailableLessThenNull(){
        
        ProductTableController controllerUnitsAvailableLessThenNull = new ProductTableController();
        
        Product_Table__c productTableRecordLessThenNull = new Product_Table__c();
        productTableRecordLessThenNull.Name = 'Samsung';
        productTableRecordLessThenNull.Product_Description__c = 'Description er Description X Description X Description X Description X Description X Description X Description X Description X Description X Description X Description X Description X Description X';
        productTableRecordLessThenNull.Title__c = 'Title Er';
        productTableRecordLessThenNull.Unit_Price__c = 500.00;
        productTableRecordLessThenNull.Units_Available__c = 10;
        insert productTableRecordLessThenNull;
        
        controllerUnitsAvailableLessThenNull.multiplier = 12;        
        controllerUnitsAvailableLessThenNull.productView = productTableRecordLessThenNull;
        
        controllerUnitsAvailableLessThenNull.saveNewOrder();
        Boolean booleanTestLessThenNull = true;
        
        System.assertEquals(booleanTestLessThenNull, controllerUnitsAvailableLessThenNull.isErrorDisplay);
        
    }

    
    @isTest static void testInsertSaveNewOrder(){
   		
		ProductTableController controllerInsert = new ProductTableController();        
         
        Product_Table__c ptrInsert = new Product_Table__c();
        ptrInsert.Name = 'Iphone 8';
        ptrInsert.Product_Description__c = 'Description X Description X Description X Description X Description X Description X Description X Description X Description X Description X Description X Description X Description X Description X';
        ptrInsert.Title__c = 'Title X';
        ptrInsert.Unit_Price__c = 600.00;
        ptrInsert.Units_Available__c = 30;
        insert ptrInsert;
        
        controllerInsert.productView = ptrInsert;
        
        controllerInsert.getContactInformation();
        controllerInsert.contactFieldAfterInsert.Email = 'john@gmail.com';
        controllerInsert.contactFieldAfterInsert.LastName = 'John';
        controllerInsert.multiplier = 3;
        controllerInsert.TotalAmount = 1800.00;
 
        controllerInsert.saveNewOrder(); 

        Order_Table__c otcInsert = new Order_Table__c();
        otcInsert.Contact__c = controllerInsert.contactFieldAfterInsert.Id;
        otcInsert.Product__c = ptrInsert.Id;
        otcInsert.Units__c = 3;
        otcInsert.Order_Amount__c = 1800.00;
        insert otcInsert;
        
    	System.assertEquals(otcInsert.Product__c, controllerInsert.orderTableRecord.Product__c);
        System.assertEquals(otcInsert.Name, controllerInsert.orderTableRecord.Name);
        System.assertEquals(otcInsert.Units__c, controllerInsert.orderTableRecord.Units__c);
        System.assertEquals(otcInsert.Order_Amount__c, controllerInsert.orderTableRecord.Order_Amount__c);
        System.assertEquals(otcInsert.Contact__c, controllerInsert.orderTableRecord.Contact__c);
        System.assertEquals(27, controllerInsert.productView.Units_Available__c);
                
    }

    @isTest static void testUpdatesaveNewOrder(){

		Contact conUpdate = new Contact();
        conUpdate.Email = 'stiven@gmail.com';
        conUpdate.LastName = 'Stiven';
        insert conUpdate;
        
        ProductTableController controllerUpdate = new ProductTableController();
        
        Product_Table__c ptcUpdate = new Product_Table__c();
        ptcUpdate.Name = 'Iphone 8';
        ptcUpdate.Product_Description__c = 'Description X Description X Description X Description X Description X Description X Description X Description X Description X Description X Description X Description X Description X Description X';
        ptcUpdate.Title__c = 'Title X';
        ptcUpdate.Unit_Price__c = 600.00;
        ptcUpdate.Units_Available__c = 30;
        insert ptcUpdate;
        
        controllerUpdate.multiplier = 2;
        
        controllerUpdate.productView = ptcUpdate;
        
        controllerUpdate.getContactInformation();
        controllerUpdate.contactFieldAfterInsert.Email = 'stiven@gmail.com';
        controllerUpdate.contactFieldAfterInsert.LastName = 'Kovi';
        controllerUpdate.contactFieldAfterInsert.FirstName = 'Stiven';
        
        controllerUpdate.saveNewOrder();
        
        Contact contactUpdateField = [SELECT Email, LastName, FirstName FROM Contact LIMIT 1];
        List<Contact> contactListUpdate = [SELECT Email, LastName, FirstName FROM Contact];
        
        System.assertEquals(conUpdate.Email, contactUpdateField.Email);
        System.assertNotEquals(conUpdate.LastName, contactUpdateField.LastName);
        System.assertNotEquals(conUpdate.FirstName, contactUpdateField.FirstName);
        System.assert(contactListUpdate.size() == 1);
        
    }
    
    
    @isTest static void testShowProductDetail(){
        
        Product_Table__c productTableRecordShowProductDetail = new Product_Table__c();  
        productTableRecordShowProductDetail.Name = 'Sony';
        productTableRecordShowProductDetail.Product_Description__c = 'sony sony';        
        insert productTableRecordShowProductDetail;
        
        ProductTableController controllerShowProductDetail = new ProductTableController();
        
        controllerShowProductDetail.productId = productTableRecordShowProductDetail.Id;
        controllerShowProductDetail.showProductDetail();
        PageReference pfSpd = controllerShowProductDetail.showProductDetail();
        String actualUrlShowProductDetail = pfSpd.getUrl();
        
        PageReference pageReferenceShowProductDetail = Page.ProductDetailPage;
		pageReferenceShowProductDetail.getParameters().put('id', productTableRecordShowProductDetail.Id);
        String expectedUrlShowProductDetail = pageReferenceShowProductDetail.getUrl();
        
        System.assertEquals(expectedUrlShowProductDetail, actualUrlShowProductDetail);
        
    }
    
    
    @isTest static void testShowProductTable(){
        
        ProductTableController controllerShowProductTable = new ProductTableController();
        controllerShowProductTable.showProductTable();
        PageReference pfSpt = controllerShowProductTable.showProductTable();
        String actualUrlShowProductTable = pfSpt.getUrl();
        
        PageReference testShowProduct = Page.ProductTablePage;
        String expectedUrlShowProductTable = testShowProduct.getUrl();
        
        System.assertEquals(expectedUrlShowProductTable, actualUrlShowProductTable);
        
    }
    
    
    @isTest static void testShowBuyAfterProductDetail(){
      
        Product_Table__c ptrShowBuyAfterProductDetail = new Product_Table__c();  
        ptrShowBuyAfterProductDetail.Name = 'Samsung';
        ptrShowBuyAfterProductDetail.Product_Description__c = 'sums sums';        
        insert ptrShowBuyAfterProductDetail;
        
        ProductTableController controllerShowBuyAfterProductDetail = new ProductTableController();
        
        PageReference prfShowBuyAfterProductDetail = Page.BuyProductPage;
		prfShowBuyAfterProductDetail.getParameters().put('id', ptrShowBuyAfterProductDetail.Id);
        prfShowBuyAfterProductDetail.getParameters().put('backTo', 'detailPage');
        String expectedShowBuyAfterUrl = prfShowBuyAfterProductDetail.getUrl();
		Test.setCurrentPage(prfShowBuyAfterProductDetail);
        
        controllerShowBuyAfterProductDetail.paramDetailId = ptrShowBuyAfterProductDetail.Id;
        controllerShowBuyAfterProductDetail.showBuyAfterProductDetail();
        PageReference testPageReference = controllerShowBuyAfterProductDetail.showBuyAfterProductDetail();
        String actualShowBuyAfterUrl = testPageReference.getUrl();
    
        System.assertEquals(expectedShowBuyAfterUrl, actualShowBuyAfterUrl);
                
    }
    
    
    @isTest static void testShowBuyProduct(){
       
        Product_Table__c ptrShowBuyProduct = new Product_Table__c();  
        ptrShowBuyProduct.Name = 'Iphone';
        ptrShowBuyProduct.Product_Description__c = 'aple aple';        
        insert ptrShowBuyProduct;
        
        ProductTableController controllerShowBuyProduct = new ProductTableController();
        
        controllerShowBuyProduct.buyId = ptrShowBuyProduct.Id;
        controllerShowBuyProduct.showBuyProduct();
        PageReference testprfShowBuyProduct = controllerShowBuyProduct.showBuyProduct();
        String actualShowBuyUrl = testprfShowBuyProduct.getUrl();
        
        PageReference pageRefSBP = Page.BuyProductPage;
		pageRefSBP.getParameters().put('id', ptrShowBuyProduct.Id);
        pageRefSBP.getParameters().put('backTo', 'mainPage');
        String expectedShowBuyUrl = pageRefSBP.getUrl();
        
        System.assertEquals(expectedShowBuyUrl, actualShowBuyUrl);
                
    }
    
    
    @isTest static void testPreviousPageMain(){
        
        PageReference pageRefPPM = Page.BuyProductPage;
		pageRefPPM.getParameters().put('backTo', 'mainPage');
		Test.setCurrentPage(pageRefPPM);        
        
        ProductTableController controllerPPM = new ProductTableController();
        controllerPPM.showPreviousPage();
        PageReference pfPPM = controllerPPM.showPreviousPage();
        String actualPreviousPageMain = pfPPM.getUrl();
        
        PageReference testPPM = Page.ProductTablePage;
        String expectedPreviousPageMain = testPPM.getUrl();
        
        System.assertEquals(expectedPreviousPageMain, actualPreviousPageMain);
         
    }
    
    
    @isTest static void testPreviousPageDetail(){        
        
        Product_Table__c ptcPreviousPageDetail = new Product_Table__c();  
        ptcPreviousPageDetail.Name = 'Xiao';
        ptcPreviousPageDetail.Product_Description__c = 'xi ao';        
        insert ptcPreviousPageDetail;      
        
        PageReference pageRefPPD = Page.BuyProductPage;
		pageRefPPD.getParameters().put('backTo', 'detailPage');
        pageRefPPD.getParameters().put('id', ptcPreviousPageDetail.Id);
		Test.setCurrentPage(pageRefPPD);        
        
        ProductTableController controllerPPD = new ProductTableController();
        controllerPPD.showPreviousPage();
        PageReference pfTestPPD = controllerPPD.showPreviousPage();
        String actualPreviousPageDetail = pfTestPPD.getUrl();
       
        PageReference testPPD = Page.ProductDetailPage;
		testPPD.getParameters().put('id', ptcPreviousPageDetail.Id);
        String expectedPreviousPageDetail = testPPD.getUrl();
        
        System.assertEquals(expectedPreviousPageDetail, actualPreviousPageDetail);
        
    }
    
    
}
