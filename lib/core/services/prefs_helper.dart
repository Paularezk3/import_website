import 'package:import_website/core/database_classes/product_attributes_and_types.dart';
import 'package:import_website/core/services/shared_preference_handler.dart';
import '../database_classes/machines_media.dart';
import '../database_classes/product_details.dart';
import '../database_classes/spare_parts_media.dart';
import 'debugging_test.dart';
import 'exceptions_handling.dart';
import 'show_snack_bar.dart';
import 'dart:convert';

class PrefsHelper {
  SharedPreferencesHandler sharedPreferencesController =
      SharedPreferencesHandler();

  Future<dynamic> makeThisOnPrefs<T>(
      Function function, List<dynamic> parameters) async {
    try {
      var v = await Function.apply(function, parameters);
      return v;
    } catch (e, stackTrace) {
      DebuggingTest.printSomething("Error ybro: ${function.toString()}");
      DebuggingTest.printSomething("Error ybro: ${parameters.toString()}");
      DebuggingTest.printSomething("Error ybro: ${e.toString()}");
      ExceptionsHandling.logExceptionToServer(e, stackTrace, "prefs Error");
      ShowSnackBar.showGetSnackbarError("Prefs Error", e.toString());
      return <T>[];
    }
  }

  String postsKey = "machines_media";
  Future<void> saveMachinesMediaToPrefs(
      List<MachinesMedia> posts, int machineId) async {
    sharedPreferencesController.saveText(postsKey, json.encode(posts));
  }

  Future<List<MachinesMedia>> loadMachinesMediaFromPrefs() async {
    var json = await sharedPreferencesController.getText(postsKey);
    if (json != null) {
      return parseMachinesMediaListItems(jsonDecode(json));
    }
    return <MachinesMedia>[];
  }

  String sparePartsMediaKey = "spare_parts_media";
  Future<void> saveSparePartsMediaToPrefs(
      List<SparePartsMedia> posts, int sparePartsID) async {
    sharedPreferencesController.saveText(sparePartsMediaKey, json.encode(posts));
  }

  Future<List<SparePartsMedia>> loadSparePartsMediaFromPrefs() async {
    var json = await sharedPreferencesController.getText(sparePartsMediaKey);
    if (json != null) {
      return parseSparePartsMediaListItems(jsonDecode(json));
    }
    return <SparePartsMedia>[];
  }

  String machinesKey = "machines";
  Future<void> saveMachinesToPrefs(List<Machines> machines) async {
    sharedPreferencesController.saveText(machinesKey, json.encode(machines));
  }

  Future<List<Machines>> loadMachinesFromPrefs() async {
    var json = await sharedPreferencesController.getText(machinesKey);
    if (json != null) {
      return parseMachinesListItems(jsonDecode(json));
    }
    return <Machines>[];
  }

  String sparePartsKey = "spare_parts";
  Future<void> saveSparePartsToPrefs(List<SpareParts> spareParts) async {
    sharedPreferencesController.saveText(
        sparePartsKey, json.encode(spareParts));
  }

  Future<List<SpareParts>> loadSparePartsFromPrefs() async {
    var json = await sharedPreferencesController.getText(sparePartsKey);
    if (json != null) {
      return parseSparePartsListItems(jsonDecode(json));
    }
    return <SpareParts>[];
  }

  String productAttributesAndTypesKey = "product_attributes_and_types";
  Future<void> saveProductAttributesAndTypesToPrefs(
      List<ProductAttributesAndTypes> productAttributesAndTypes) async {
    sharedPreferencesController.saveText(
        productAttributesAndTypesKey, json.encode(productAttributesAndTypes));
  }

  Future<List<ProductAttributesAndTypes>>
      loadProductAttributesAndTypesFromPrefs() async {
    var json =
        await sharedPreferencesController.getText(productAttributesAndTypesKey);
    if (json != null) {
      return parseProductAttributesAndTypesListItems(jsonDecode(json));
    }
    return <ProductAttributesAndTypes>[];
  }

  String machineSparePartsKey = "machine_spare_parts";
  Future<void> saveMachineSparePartsToPrefs(
      List<SpareParts> machineSpareParts, int machineId) async {
    sharedPreferencesController.saveText(
        "${machineSparePartsKey}_$machineId", json.encode(machineSpareParts));
  }

  Future<List<SpareParts>> loadMachineSparePartsFromPrefs(int machineId) async {
    var json = await sharedPreferencesController.getText("${machineSparePartsKey}_$machineId");
    if (json != null) {
      return parseSparePartsListItems(jsonDecode(json));
    }
    return <SpareParts>[];
  }

  // Future<void> saveCustomerInvoiceOffersToPrefs(
  //     List<dynamic> offers, int customerID) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'invoice_offers_$customerID';
  //   prefs.setString(key, json.encode(offers));
  // }

  // Future<List<InvoiceOffer>> loadCustomerInvoiceOffersFromPrefs(
  //     int customerID) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'invoice_offers_$customerID';
  //   if (prefs.containsKey(key)) {
  //     return parseInvoiceOffers(json.decode(prefs.getString(key)!));
  //   }
  //   return <InvoiceOffer>[];
  // }

  // Future<void> saveSparePartsToPrefs(List<dynamic> spareParts) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'spare_parts';
  //   prefs.setString(key, json.encode(spareParts));
  // }

  // Future<List<SparePartsListItem>> loadSparePartsFromPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'spare_parts';
  //   if (prefs.containsKey(key)) {
  //     return parseSparePartListItems(json.decode(prefs.getString(key)!));
  //   }
  //   return <SparePartsListItem>[];
  // }

  // Future<void> saveCustomerInvoiceOffersToPrefs(
  //     List<dynamic> offers, int customerID) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'invoice_offers_$customerID';
  //   prefs.setString(key, json.encode(offers));
  // }

  // Future<List<InvoiceOffer>> loadCustomerInvoiceOffersFromPrefs(
  //     int customerID) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'invoice_offers_$customerID';
  //   if (prefs.containsKey(key)) {
  //     return parseInvoiceOffers(json.decode(prefs.getString(key)!));
  //   }
  //   return <InvoiceOffer>[];
  // }

  // Future<void> saveCustomerOrdersToPrefs(
  //     List<dynamic> transactions, int customerID) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'customer_orders_$customerID';
  //   prefs.setString(key, json.encode(transactions));
  // }

  // Future<List<CustomerOrdersListItem>> loadCustomerOrdersFromPrefs(
  //     int customerID) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'customer_orders_$customerID';
  //   if (prefs.containsKey(key)) {
  //     return parseCustomerOrdersListItem(json.decode(prefs.getString(key)!));
  //   }
  //   return <CustomerOrdersListItem>[];
  // }

  // Future<void> saveCustomerMoneyTransactionToPrefs(
  //     List<dynamic> transactions, int customerID) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'money_transactions_$customerID';
  //   prefs.setString(key, json.encode(transactions));
  // }

  // Future<List<MoneyTransaction>> loadCustomerMoneyTransactionFromPrefs(
  //     int customerID) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'money_transactions_$customerID';
  //   if (prefs.containsKey(key)) {
  //     return parseMoneyTransactions(json.decode(prefs.getString(key)!));
  //   }
  //   return <MoneyTransaction>[];
  // }

  // Future<void> saveCustomerPartTransactionToPrefs(
  //     List<dynamic> transactions, int customerID) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'customer_part_transactions_$customerID';
  //   prefs.setString(key, json.encode(transactions));
  // }

  // Future<List<CustomerTransactionListItem>>
  //     loadCustomerPartTransactionFromPrefs(int customerID) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'customer_part_transactions_$customerID';
  //   if (prefs.containsKey(key)) {
  //     String partTransactions = prefs.getString(key)!;
  //     return parsePartTransactions(
  //         json.decode(partTransactions));
  //   }
  //   return <CustomerTransactionListItem>[];
  // }

  // Future<void> saveCustomerOrderPartAndMoneyTransactionToPrefs(
  //     List<dynamic> transactions, int orderID) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'order_part_and_money_transactions_$orderID';
  //   prefs.setString(key, json.encode(transactions));
  // }

  // Future<List<CustomerTransactionListItem>>
  //     loadCustomerOrderPartAndMoneyTransactionFromPrefs(int orderID) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'order_part_and_money_transactions_$orderID';
  //   if (prefs.containsKey(key)) {
  //     String partTransactions = prefs.getString(key)!;
  //     return parseCustomerOrderPartAndMoneyTransactionsListItem(
  //         json.decode(partTransactions));
  //   }
  //   return <CustomerTransactionListItem>[];
  // }

  // Future<void> saveInventoryPartsOutsideEgyptToPrefs(
  //     List<dynamic> inventoryParts) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'inventory_parts_outside_egypt';
  //   prefs.setString(key, json.encode(inventoryParts));
  // }

  // Future<List<InventoryPartsOutsideEgypt>>
  //     loadInventoryPartsOutsideEgyptFromPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'inventory_parts_outside_egypt';
  //   if (prefs.containsKey(key)) {
  //     String inventory = prefs.getString(key)!;
  //     return parseInventoryPartsOutsideEgypt(json.decode(inventory));
  //   }
  //   return <InventoryPartsOutsideEgypt>[];
  // }

  // Future<void> saveInventoryPartsDomesticToPrefs(
  //     List<dynamic> inventoryParts) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'inventory_parts_domestic';
  //   prefs.setString(key, json.encode(inventoryParts));
  // }

  // Future<List<InventoryPartsDomestic>>
  //     loadInventoryPartsDomesticFromPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'inventory_parts_domestic';
  //   if (prefs.containsKey(key)) {
  //     String inventory = prefs.getString(key)!;
  //     return parseInventoryPartsDomestic(json.decode(inventory));
  //   }
  //   return <InventoryPartsDomestic>[];
  // }

  // Future<void> saveInventoryPartsMergedToPrefs(
  //     List<dynamic> inventoryParts) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'inventory_parts_merged';
  //   prefs.setString(key, json.encode(inventoryParts));
  // }

  // Future<List<InventoryPartsMergedListItem>>
  //     loadInventoryPartsMergedFromPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'inventory_parts_merged';
  //   if (prefs.containsKey(key)) {
  //     String inventory = prefs.getString(key)!;
  //     return parseInventoryPartsMerged(json.decode(inventory));
  //   }
  //   return <InventoryPartsMergedListItem>[];
  // }

  // Future<void> saveFactoriesToPrefs(List<dynamic> factories) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'factories';
  //   prefs.setString(key, json.encode(factories));
  // }

  // Future<List<FactoryListItem>> loadFactoriesFromPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'factories';
  //   if (prefs.containsKey(key)) {
  //     String factories = prefs.getString(key)!;
  //     return parseFactoryListItem(json.decode(factories));
  //   }
  //   return <FactoryListItem>[];
  // }

  // Future<void> saveInventoryPartOutsideEgyptTransactionToPrefs(
  //   List<dynamic> transactions,
  //   int factoryOrderDetailsID,
  // ) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key =
  //       'Inventory_part_outside_egypt_transactions_$factoryOrderDetailsID';
  //   prefs.setString(key, json.encode(transactions));
  // }

  // Future<List<InventoryPartOutsideEgyptTransactionsListItem>>
  //     loadInventoryPartOutsideEgyptTransactionFromPrefs(
  //         int factoryOrderDetailsID) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key =
  //       'Inventory_part_outside_egypt_transactions_$factoryOrderDetailsID';
  //   if (prefs.containsKey(key)) {
  //     String inventoryPartTransactions = prefs.getString(key)!;
  //     return parseInventoryPartOutsideEgyptTransactionItems(
  //         json.decode(inventoryPartTransactions));
  //   }
  //   return <InventoryPartOutsideEgyptTransactionsListItem>[];
  // }

  // Future<void> saveInventoryPartDomesticTransactionToPrefs(
  //   List<dynamic> transactions,
  //   int factoryOrderDetailsID,
  // ) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'Inventory_part_domestic_transactions_$factoryOrderDetailsID';
  //   prefs.setString(key, json.encode(transactions));
  // }

  // Future<List<InventoryPartDomesticTransactionsListItem>>
  //     loadInventoryPartDomesticTransactionFromPrefs(
  //         int factoryOrderDetailsID) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'Inventory_part_domestic_transactions_$factoryOrderDetailsID';
  //   if (prefs.containsKey(key)) {
  //     String inventoryPartTransactions = prefs.getString(key)!;
  //     return parseInventoryPartDomesticTransactionItems(
  //         json.decode(inventoryPartTransactions));
  //   }
  //   return <InventoryPartDomesticTransactionsListItem>[];
  // }

  // Future<void> saveAllCustomersInvoiceOffersToPrefs(
  //     List<dynamic> offers) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'all_customers_invoice_offers';
  //   prefs.setString(key, json.encode(offers));
  // }

  // // Future<List<InvoiceOffer>> loadAllCustomersInvoiceOffersFromPrefs() async {
  // //   SharedPreferences prefs = await SharedPreferences.getInstance();
  // //   String key = 'all_customers_invoice_offers';
  // //   if (prefs.containsKey(key)) {
  // //     return parseInvoiceOffers(json.decode(prefs.getString(key)!));
  // //   }
  // //   return <InvoiceOffer>[];
  // // }

  // Future<void> saveAllCustomersMoneyTransactionsToPrefs(
  //     List<dynamic> transactions) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'all_customers_money_transactions';
  //   prefs.setString(key, json.encode(transactions));
  // }

  // Future<List<MoneyTransaction>>
  //     loadAllCustomersMoneyTransactionsFromPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'all_customers_money_transactions';
  //   if (prefs.containsKey(key)) {
  //     return parseMoneyTransactions(json.decode(prefs.getString(key)!));
  //   }
  //   return <MoneyTransaction>[];
  // }

  // Future<void> saveAllCustomersPartTransactionsToPrefs(
  //     List<dynamic> transactions) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'all_customers_part_transactions';
  //   prefs.setString(key, json.encode(transactions));
  // }

  // Future<List<PartTransaction>>
  //     loadAllCustomersPartTransactionsFromPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'all_customers_part_transactions';
  //   if (prefs.containsKey(key)) {
  //     String partTransactions = prefs.getString(key)!;
  //     return parsePartTransactions(json.decode(partTransactions));
  //   }
  //   return <PartTransaction>[];
  // }

  // Future<void> saveInventoryImportsOutsideEgyptToPrefs(
  //     List<dynamic> transactions) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'inventory_imports_outside_egypt';
  //   prefs.setString(key, json.encode(transactions));
  // }

  // Future<List<InventoryImportsOutsideEgyptListItem>>
  //     loadInventoryImportsOutsideEgyptFromPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'inventory_imports_outside_egypt';
  //   if (prefs.containsKey(key)) {
  //     String inventoryImportsOutsideEgypt = prefs.getString(key)!;
  //     return parseInventoryImportsOutsideEgyptItems(
  //         json.decode(inventoryImportsOutsideEgypt));
  //   }
  //   return <InventoryImportsOutsideEgyptListItem>[];
  // }

  // Future<void> saveInventoryImportsDomesticToPrefs(
  //     List<dynamic> transactions) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'inventory_imports_domestic';
  //   prefs.setString(key, json.encode(transactions));
  // }

  // Future<List<InventoryImportsDomesticListItem>>
  //     loadInventoryImportsDomesticFromPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'inventory_imports_domestic';
  //   if (prefs.containsKey(key)) {
  //     String inventoryImportsOutsideEgypt = prefs.getString(key)!;
  //     return parseInventoryImportsDomesticListItem(
  //         json.decode(inventoryImportsOutsideEgypt));
  //   }
  //   return <InventoryImportsDomesticListItem>[];
  // }

  // Future<void> saveImportPartsOutsideEgyptToPrefs(
  //     List<dynamic> offers, int orderID) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'import_parts_outside_egypt_$orderID';
  //   prefs.setString(key, json.encode(offers));
  // }

  // Future<List<InventoryPartsOutsideEgypt>> loadImportPartsOutsideEgyptFromPrefs(
  //     int orderID) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'import_parts_outside_egypt_$orderID';
  //   if (prefs.containsKey(key)) {
  //     return parseImportPartsOutsideEgypt(json.decode(prefs.getString(key)!));
  //   }
  //   return <InventoryPartsOutsideEgypt>[];
  // }

  // Future<void> saveImportPartsDomesticToPrefs(
  //     List<dynamic> offers, int orderID) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'import_parts_domestic_$orderID';
  //   prefs.setString(key, json.encode(offers));
  // }

  // Future<List<InventoryPartsDomestic>> loadImportPartsDomesticFromPrefs(
  //     int orderID) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'import_parts_outside_egypt_$orderID';
  //   if (prefs.containsKey(key)) {
  //     return parseImportPartsDomestic(json.decode(prefs.getString(key)!));
  //   }
  //   return <InventoryPartsDomestic>[];
  // }

  // Future<List<TotalSalesListItem>> loadTotalSalesWithSpecificDateFromPrefs(
  //     DateTime startDate, DateTime endDate) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'total_sales_from_${startDate}_to_$endDate';
  //   if (prefs.containsKey(key)) {
  //     return parseTotalSalesListItem(json.decode(prefs.getString(key)!));
  //   }
  //   return <TotalSalesListItem>[];
  // }

  // Future<void> saveTotalSalesWithSpecificDateToPrefs(
  //     List<dynamic> transactions, DateTime startDate, DateTime endDate) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'total_sales_from_${startDate}_to_$endDate';
  //   prefs.setString(key, json.encode(transactions));
  // }

  // Future<List<SalesOrdersListItem>> loadSalesOrdersWithSpecificDateFromPrefs(
  //     DateTime startDate, DateTime endDate) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'sales_orders_from_${startDate}_to_$endDate';
  //   if (prefs.containsKey(key)) {
  //     return parseSalesOrdersListItems(json.decode(prefs.getString(key)!));
  //   }
  //   return <SalesOrdersListItem>[];
  // }

  // Future<void> saveSalesOrdersWithSpecificDateToPrefs(
  //     List<dynamic> transactions, DateTime startDate, DateTime endDate) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'sales_orders_from_${startDate}_to_$endDate';
  //   prefs.setString(key, json.encode(transactions));
  // }

  // Future<List<SalesOrdersListItem>> loadSalesOrdersFromPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'sales_orders';
  //   if (prefs.containsKey(key)) {
  //     return parseSalesOrdersListItems(json.decode(prefs.getString(key)!));
  //   }
  //   return <SalesOrdersListItem>[];
  // }

  // Future<void> saveSalesOrdersToPrefs(
  //     List<dynamic> transactions) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'sales_orders';
  //   prefs.setString(key, json.encode(transactions));
  // }

  // Future<void> saveCustomersStatisticsToPrefs(List<dynamic> customers) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'customers_statistics';
  //   prefs.setString(key, json.encode(customers));
  // }

  // Future<List<CustomerStatisticsListItem>> loadCustomersStatisticsFromPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'customers_statistics';
  //   if (prefs.containsKey(key)) {
  //     return parseCustomerStatisticsListItems(json.decode(prefs.getString(key)!));
  //   }
  //   return <CustomerStatisticsListItem>[];
  // }

  // Future<void> saveTopPartsToPrefs(List<dynamic> customers) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'top_parts';
  //   prefs.setString(key, json.encode(customers));
  // }

  // Future<List<TopPartsListItem>> loadTopPartsFromPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'top_parts';
  //   if (prefs.containsKey(key)) {
  //     return parseTopPartsListItem(json.decode(prefs.getString(key)!));
  //   }
  //   return <TopPartsListItem>[];
  // }

  // Future<void> saveAllSalesMonthlyToPrefs(List<dynamic> customers) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'all_sales_monthly';
  //   prefs.setString(key, json.encode(customers));
  // }

  // Future<List<AllSalesMonthlyListItem>> loadAllSalesMonthlyFromPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String key = 'all_sales_monthly';
  //   if (prefs.containsKey(key)) {
  //     return parseAllSalesMonthlyListItem(json.decode(prefs.getString(key)!));
  //   }
  //   return <AllSalesMonthlyListItem>[];
  // }
}
