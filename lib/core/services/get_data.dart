import 'dart:async';
import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:import_website/core/database_classes/posts.dart';
import 'package:import_website/core/database_classes/product_attributes_and_types.dart';

import '../database_classes/product_details.dart';
import 'data_repository.dart';
import 'debugging_test.dart';
import 'exceptions_handling.dart';
import 'prefs_helper.dart';
import 'show_snack_bar.dart';

class GetData extends GetxController {
  final DataRepository _repository;
  final PrefsHelper _prefs;

  GetData(this._repository, this._prefs);

  void handleError(String h, Object e, StackTrace s) {
    DebuggingTest.printSomething(e.toString());
    ExceptionsHandling.logExceptionToServer(e, s, h);
    ShowSnackBar.showGetSnackbarError(
        "Error", "An error occurred while $h! ${e.toString()}");
  }

  // void handleErrors(String h, Object e, Function function,
  //     [List<dynamic> parameters = const []]) {
  //   DebuggingTest.printSomething(e.toString());

  //   // if (e.toString().contains('Failed host lookup')) {
  //   if (true) {
  //     DebuggingTest.printSomething('retry connection');
  //     ShowSnackBar.showLoadingSnackBar();
  //     Function.apply(function, parameters);
  //     ShowSnackBar.hideCurrentSnackBar();
  //     // Handle the error
  //   } else {
  //     ShowSnackBar.showErrorSnackBar(
  //         "An error occurred while $h! ${e.toString()}");
  //   }
  // }

  Future<RxList<T>> getAndSave<T>(
      Function repoFunction,
      List<dynamic> repoParameters,
      Function parseFunction,
      List<dynamic> parseParameters,
      Function prefsFunction,
      List<dynamic> prefsParameters,
      List<T> itemToCompareWith,
      String errorString) async {
    try {
      List<dynamic> newFetched =
          await Function.apply(repoFunction, repoParameters);
      List<T> newItemList =
          Function.apply(parseFunction, [newFetched, ...parseParameters]);
      if (!const DeepCollectionEquality()
          .equals(itemToCompareWith, newItemList)) {
        _prefs
            .makeThisOnPrefs(prefsFunction, [newItemList, ...prefsParameters]);
        return RxList<T>(newItemList);
      } else {
        return RxList<T>(newItemList);
      }
    } catch (e, stackTrace) {
      // handleErrors(errorString, e, getAndSave, [
      //   repoFunction,
      //   repoParameters,
      //   parseFunction,
      //   parseParameters,
      //   prefsFunction,
      //   prefsParameters,
      //   itemToCompareWith,
      // ]);
      handleError(errorString, e, stackTrace);
    }
    return RxList<T>(itemToCompareWith);
  }

  Future<void> post(
    Function repoFunction,
    List<dynamic> repoParameters,
    String errorString,
  ) async {
    try {
      repoParameters.add(errorString);
      await Function.apply(repoFunction, repoParameters);
      // for (var map in updateFunctions) {
      //   Function function = map['function'];
      //   List<dynamic> parameters = map['parameters'];
      //   await Function.apply(function, parameters);
      // }
    } catch (e, stackTrace) {
      handleError(errorString, e, stackTrace);
    }
  }

  RxList<Posts> posts = RxList<Posts>();

  Future<List<Posts>> getPosts() async {
    posts.value =
        await _prefs.makeThisOnPrefs<Posts>(_prefs.loadPostsFromPrefs, []);

    posts.value = await getAndSave<Posts>(
        _repository.fetchPostsFromServer,
        [],
        parsePostsListItems,
        [],
        _prefs.savePostsToPrefs,
        [],
        posts.toList(),
        "Getting Posts");

    return posts.toList();
  }

  RxList<Machines> machines = RxList<Machines>();

  Future<List<Machines>> getMachines() async {
    machines.value = await _prefs
        .makeThisOnPrefs<Machines>(_prefs.loadMachinesFromPrefs, []);

    machines.value = await getAndSave<Machines>(
        _repository.fetchMachinesFromServer,
        [],
        parseMachinesListItems,
        [],
        _prefs.saveMachinesToPrefs,
        [],
        machines.toList(),
        "Getting Machines");

    return machines.toList();
  }

  RxList<SpareParts> spareParts = RxList<SpareParts>();

  Future<List<SpareParts>> getSpareParts() async {
    spareParts.value = await _prefs
        .makeThisOnPrefs<SpareParts>(_prefs.loadSparePartsFromPrefs, []);

    spareParts.value = await getAndSave<SpareParts>(
        _repository.fetchSparePartsFromServer,
        [],
        parseSparePartsListItems,
        [],
        _prefs.saveSparePartsToPrefs,
        [],
        spareParts.toList(),
        "Getting Spare Parts");

    return spareParts.toList();
  }

  RxList<ProductAttributesAndTypes> productAttributesAndTypes =
      RxList<ProductAttributesAndTypes>();

  Future<List<ProductAttributesAndTypes>> getProductAttributesAndTypes() async {
    productAttributesAndTypes.value = await _prefs
        .makeThisOnPrefs<ProductAttributesAndTypes>(
            _prefs.loadProductAttributesAndTypesFromPrefs, []);

    productAttributesAndTypes.value =
        await getAndSave<ProductAttributesAndTypes>(
            _repository.fetchProductAttributesAndTypesFromServer,
            [],
            parseProductAttributesAndTypesListItems,
            [],
            _prefs.saveProductAttributesAndTypesToPrefs,
            [],
            productAttributesAndTypes.toList(),
            "Getting Product Attributes And Types");

    return productAttributesAndTypes.toList();
  }

  RxList<SpareParts> machineSpareParts =
      RxList<SpareParts>();

  Future<List<SpareParts>> getMachineSpareParts(
      int machineId) async {
    machineSpareParts.value = await _prefs
        .makeThisOnPrefs<SpareParts>(
            _prefs.loadMachineSparePartsFromPrefs, [machineId]);

    machineSpareParts.value =
        await getAndSave<SpareParts>(
            _repository.fetchMachineSparePartsFromServer,
            [machineId],
            parseSparePartsListItems,
            [],
            _prefs.saveMachineSparePartsToPrefs,
            [machineId],
            machineSpareParts.toList(),
            "Getting Machine Spare Parts");

    return machineSpareParts.toList();
  }

  Future<void> addCustomerToNewsletter(String name, String email) async {
    await post(_repository.addCustomerToNewsletterToServer, [name, email],
        "Adding Customer to Newsletter");
  }

  Future<void> addCustomerInquiry(
      String name, String email, String description) async {
    await post(_repository.addCustomerInquiryToServer,
        [name, email, description], "Adding Customer Inquiry");
  }

  // Future<void> addSparePart(
  //     String sparePartName, String sparePartNumber, String carModel) async {
  //   await post(_repository.addSparePartToServer,
  //       [sparePartName, sparePartNumber, carModel], "Adding Spare Part");
  // }

  // // Future<void> addInvoiceOffer(
  // //     String customerID, String date, String details, String amount) async {
  // //   await post(_repository.addInvoiceOfferToServer,
  // //       [customerID, date, details, amount], "Adding Invoice Offer");

  // //   await getCustomerInvoicesOffers(int.parse(customerID));
  // //   updateCustomerMergedTransactions();
  // //   getCustomers();
  // // }

  // Future<void> addMoneyTransaction(
  //     int? currentCustomerOrderID,
  //     String customerId,
  //     String date,
  //     String details,
  //     String amount,
  //     String isIncome,
  //     String customerOrderID) async {
  //   await post(
  //       _repository.addMoneyTransactionToServer,
  //       [customerId, date, details, amount, isIncome, customerOrderID],
  //       "Adding Money Transaction");
  //   if (currentCustomerOrderID != null) {
  //     await getCustomerPartAndMoneyTransaction(currentCustomerOrderID);
  //   }
  //   await getCustomerOrders(int.parse(customerId));
  //   getCustomers();
  // }

  // Future<void> addPartTransaction(
  //     int currentCustomerOrderID,
  //     String customerId,
  //     String customerOrderID,
  //     String date,
  //     String details,
  //     String orderDetailsID,
  //     String quantity,
  //     String sparePartPrice,
  //     String orderDetailSource,
  //     String isIncoming) async {
  //   await post(
  //       _repository.addPartTransactionToServer,
  //       [
  //         customerId,
  //         customerOrderID,
  //         date,
  //         details,
  //         orderDetailsID,
  //         quantity,
  //         sparePartPrice,
  //         orderDetailSource,
  //         isIncoming
  //       ],
  //       "Adding Part Transaction");
  //   await getCustomerPartAndMoneyTransaction(currentCustomerOrderID);
  //   await getCustomerOrders(int.parse(customerId));
  //   getCustomers();
  // }

  // RxList<FactoryListItem> factories = RxList<FactoryListItem>();

  // Future<List<FactoryListItem>> getFactories() async {
  //   factories.value = await _prefs
  //       .makeThisOnPrefs<FactoryListItem>(_prefs.loadFactoriesFromPrefs, []);

  //   factories.value = await getAndSave(
  //       _repository.fetchFactoriesFromServer,
  //       [],
  //       parseFactoryListItem,
  //       [],
  //       _prefs.saveFactoriesToPrefs,
  //       [],
  //       factories.toList(),
  //       "Getting Inventory");

  //   return factories.toList();
  // }

  // Future<void> addFactoryOrder(
  //     String factoryId,
  //     String orderDate,
  //     String rmbExchange,
  //     String importerName,
  //     String arrivalTime,
  //     String customsPrice,
  //     String invoiceOffer,
  //     String partsOrdered) async {
  //   post(
  //       _repository.addFactoryOrderToServer,
  //       [
  //         factoryId,
  //         orderDate,
  //         rmbExchange,
  //         importerName,
  //         arrivalTime,
  //         customsPrice,
  //         invoiceOffer,
  //         partsOrdered
  //       ],
  //       "Adding Factory Order");
  // }

  // Future<void> addDomesticOrderToServer(
  //     String supplierName,
  //     String invoiceOffer,
  //     String orderDate,
  //     String orderPrice,
  //     String partsOrdered) async {
  //   post(
  //       _repository.addDomesticOrderToServer,
  //       [supplierName, invoiceOffer, orderDate, orderPrice, partsOrdered],
  //       "Adding Domestic Order");
  // }

  // RxList<InventoryPartOutsideEgyptTransactionsListItem>
  //     inventoryPartOutsideEgyptTransactions =
  //     RxList<InventoryPartOutsideEgyptTransactionsListItem>();

  // Future<List<InventoryPartOutsideEgyptTransactionsListItem>>
  //     getInventoryPartOutsideEgyptTransaction(int factoryOrderDetailsID) async {
  //   inventoryPartOutsideEgyptTransactions.value = await _prefs
  //       .makeThisOnPrefs<InventoryPartOutsideEgyptTransactionsListItem>(
  //           _prefs.loadInventoryPartOutsideEgyptTransactionFromPrefs,
  //           [factoryOrderDetailsID]);

  //   inventoryPartOutsideEgyptTransactions.value = await getAndSave(
  //       _repository.fetchInventoryPartOutsideEgyptTransactionFromServer,
  //       [factoryOrderDetailsID],
  //       parseInventoryPartOutsideEgyptTransactionItems,
  //       [],
  //       _prefs.saveInventoryPartOutsideEgyptTransactionToPrefs,
  //       [factoryOrderDetailsID],
  //       inventoryPartOutsideEgyptTransactions.toList(),
  //       "Getting Inventory Part Transaction Globally");

  //   return inventoryPartOutsideEgyptTransactions.toList();
  // }

  // RxList<InventoryPartDomesticTransactionsListItem>
  //     inventoryPartDomesticTransactions =
  //     RxList<InventoryPartDomesticTransactionsListItem>();

  // Future<List<InventoryPartDomesticTransactionsListItem>>
  //     getInventoryPartDomesticTransaction(int importOrderDetailsID) async {
  //   inventoryPartDomesticTransactions.value = await _prefs
  //       .makeThisOnPrefs<InventoryPartDomesticTransactionsListItem>(
  //           _prefs.loadInventoryPartDomesticTransactionFromPrefs,
  //           [importOrderDetailsID]);

  //   inventoryPartDomesticTransactions.value = await getAndSave(
  //       _repository.fetchInventoryPartDomesticTransactionFromServer,
  //       [importOrderDetailsID],
  //       parseInventoryPartDomesticTransactionItems,
  //       [],
  //       _prefs.saveInventoryPartDomesticTransactionToPrefs,
  //       [importOrderDetailsID],
  //       inventoryPartDomesticTransactions.toList(),
  //       "Getting Inventory Part Transaction Domestic");

  //   return inventoryPartDomesticTransactions.toList();
  // }

  // // RxList<InvoiceOffer> allCustomersInvoiceOffers = RxList<InvoiceOffer>();

  // // Future<List<InvoiceOffer>> getAllCustomersInvoicesOffers() async {
  // //   allCustomersInvoiceOffers.value = await _prefs
  // //       .makeThisOnPrefs<InvoiceOffer>(
  // //           _prefs.loadAllCustomersInvoiceOffersFromPrefs, []);

  // //   allCustomersInvoiceOffers.value = await getAndSave<InvoiceOffer>(
  // //       _repository.fetchAllCustomersInvoiceOffersFromServer,
  // //       [],
  // //       parseInvoiceOffers,
  // //       [],
  // //       _prefs.saveAllCustomersInvoiceOffersToPrefs,
  // //       [],
  // //       allCustomersInvoiceOffers.toList(),
  // //       "Getting All Customers Invoices Offers");

  // //   return allCustomersInvoiceOffers.toList();
  // // }

  // RxList<MoneyTransaction> allCustomersMoneyTransactions =
  //     RxList<MoneyTransaction>();

  // Future<List<MoneyTransaction>> getAllCustomersMoneyTransactions() async {
  //   allCustomersMoneyTransactions.value = await _prefs
  //       .makeThisOnPrefs<MoneyTransaction>(
  //           _prefs.loadAllCustomersMoneyTransactionsFromPrefs, []);

  //   allCustomersMoneyTransactions.value = await getAndSave<MoneyTransaction>(
  //       _repository.fetchAllCustomersMoneyTransactionsFromServer,
  //       [],
  //       parseMoneyTransactions,
  //       [],
  //       _prefs.saveAllCustomersMoneyTransactionsToPrefs,
  //       [],
  //       allCustomersMoneyTransactions.toList(),
  //       "Getting All Customers Money Transactions");

  //   return allCustomersMoneyTransactions.toList();
  // }

  // RxList<PartTransaction> allCustomersPartTransactions =
  //     RxList<PartTransaction>();

  // Future<List<PartTransaction>> getAllCustomersPartTransactions() async {
  //   allCustomersPartTransactions.value = await _prefs
  //       .makeThisOnPrefs<PartTransaction>(
  //           _prefs.loadAllCustomersPartTransactionsFromPrefs, []);

  //   allCustomersPartTransactions.value = await getAndSave<PartTransaction>(
  //       _repository.fetchAllCustomersPartTransactionsFromServer,
  //       [],
  //       parsePartTransactions,
  //       [],
  //       _prefs.saveAllCustomersPartTransactionsToPrefs,
  //       [],
  //       allCustomersPartTransactions.toList(),
  //       "Getting All Customers Parts Transactions");

  //   return allCustomersPartTransactions.toList();
  // }

  // RxList<InventoryImportsOutsideEgyptListItem> inventoryImportsOutsideEgypt =
  //     RxList<InventoryImportsOutsideEgyptListItem>();

  // Future<List<InventoryImportsOutsideEgyptListItem>>
  //     getInventoryImportsOutsideEgypt() async {
  //   inventoryImportsOutsideEgypt.value = await _prefs
  //       .makeThisOnPrefs<InventoryImportsOutsideEgyptListItem>(
  //           _prefs.loadInventoryImportsOutsideEgyptFromPrefs, []);

  //   inventoryImportsOutsideEgypt.value =
  //       await getAndSave<InventoryImportsOutsideEgyptListItem>(
  //           _repository.fetchInventoryImportsOutsideEgyptFromServer,
  //           [],
  //           parseInventoryImportsOutsideEgyptItems,
  //           [],
  //           _prefs.saveInventoryImportsOutsideEgyptToPrefs,
  //           [],
  //           inventoryImportsOutsideEgypt.toList(),
  //           "Getting Inventory Imports Outside Egypt");

  //   return inventoryImportsOutsideEgypt.toList();
  // }

  // RxList<InventoryImportsDomesticListItem> inventoryImportsDomestic =
  //     RxList<InventoryImportsDomesticListItem>();

  // Future<List<InventoryImportsDomesticListItem>>
  //     getInventoryImportsDomestic() async {
  //   inventoryImportsDomestic.value = await _prefs
  //       .makeThisOnPrefs<InventoryImportsDomesticListItem>(
  //           _prefs.loadInventoryImportsDomesticFromPrefs, []);

  //   inventoryImportsDomestic.value =
  //       await getAndSave<InventoryImportsDomesticListItem>(
  //           _repository.fetchInventoryImportsDomesticFromServer,
  //           [],
  //           parseInventoryImportsDomesticListItem,
  //           [],
  //           _prefs.saveInventoryImportsDomesticToPrefs,
  //           [],
  //           inventoryImportsDomestic.toList(),
  //           "Getting Inventory Imports Domestic");

  //   return inventoryImportsDomestic.toList();
  // }

  // RxList<InventoryPartsOutsideEgypt> importPartsOutsideEgypt =
  //     RxList<InventoryPartsOutsideEgypt>();

  // Future<List<InventoryPartsOutsideEgypt>> getImportPartsOutsideEgypt(
  //     int orderID) async {
  //   inventoryPartsOutsideEgypt.value = await _prefs
  //       .makeThisOnPrefs<InventoryPartsOutsideEgypt>(
  //           _prefs.loadImportPartsOutsideEgyptFromPrefs, [orderID]);

  //   importPartsOutsideEgypt.value =
  //       await getAndSave<InventoryPartsOutsideEgypt>(
  //           _repository.fetchImportPartsOutsideEgyptFromServer,
  //           [orderID],
  //           parseImportPartsOutsideEgypt,
  //           [],
  //           _prefs.saveImportPartsOutsideEgyptToPrefs,
  //           [orderID],
  //           importPartsOutsideEgypt.toList(),
  //           "Getting Import Parts Outside Egypt");

  //   return importPartsOutsideEgypt.toList();
  // }

  // RxList<InventoryPartsDomestic> importPartsDomestic =
  //     RxList<InventoryPartsDomestic>();

  // Future<List<InventoryPartsDomestic>> getImportPartsDomestic(
  //     int orderID) async {
  //   importPartsDomestic.value = await _prefs
  //       .makeThisOnPrefs<InventoryPartsDomestic>(
  //           _prefs.loadImportPartsDomesticFromPrefs, [orderID]);

  //   importPartsDomestic.value = await getAndSave<InventoryPartsDomestic>(
  //       _repository.fetchImportPartsDomesticFromServer,
  //       [orderID],
  //       parseImportPartsDomestic,
  //       [],
  //       _prefs.saveImportPartsDomesticToPrefs,
  //       [orderID],
  //       importPartsDomestic.toList(),
  //       "Getting Import Parts Domestic");

  //   return importPartsDomestic.toList();
  // }

  // RxList<TotalSalesListItem> totalSalesWithSpecificDate =
  //     RxList<TotalSalesListItem>();

  // Future<List<TotalSalesListItem>> getTotalSalesWithSpecificDate(
  //     DateTime startDate, DateTime endDate) async {
  //   totalSalesWithSpecificDate.value = await _prefs
  //       .makeThisOnPrefs<TotalSalesListItem>(
  //           _prefs.loadTotalSalesWithSpecificDateFromPrefs,
  //           [startDate, endDate]);

  //   totalSalesWithSpecificDate.value = await getAndSave<TotalSalesListItem>(
  //       _repository.fetchTotalSalesWithSpecificDateFromServer,
  //       [startDate, endDate],
  //       parseTotalSalesListItem,
  //       [],
  //       _prefs.saveTotalSalesWithSpecificDateToPrefs,
  //       [startDate, endDate],
  //       totalSalesWithSpecificDate.toList(),
  //       "Getting Money Transactions");

  //   return totalSalesWithSpecificDate.toList();
  // }

  // RxList<SalesOrdersListItem> salesOrdersWithSpecificDate =
  //     RxList<SalesOrdersListItem>();

  // Future<List<SalesOrdersListItem>> getsalesOrderWithSpecificDate(
  //     DateTime startDate, DateTime endDate) async {
  //   salesOrdersWithSpecificDate.value = await _prefs
  //       .makeThisOnPrefs<SalesOrdersListItem>(
  //           _prefs.loadSalesOrdersWithSpecificDateFromPrefs,
  //           [startDate, endDate]);

  //   salesOrdersWithSpecificDate.value = await getAndSave<SalesOrdersListItem>(
  //       _repository.fetchSalesOrdersWithSpecificDateFromServer,
  //       [startDate, endDate],
  //       parseSalesOrdersListItems,
  //       [],
  //       _prefs.saveSalesOrdersWithSpecificDateToPrefs,
  //       [startDate, endDate],
  //       salesOrdersWithSpecificDate.toList(),
  //       "Getting Sales Orders With Specific Date");

  //   return salesOrdersWithSpecificDate.toList();
  // }

  // RxList<SalesOrdersListItem> salesOrders = RxList<SalesOrdersListItem>();

  // Future<List<SalesOrdersListItem>> getsalesOrders() async {
  //   salesOrders.value = await _prefs.makeThisOnPrefs<SalesOrdersListItem>(
  //       _prefs.loadSalesOrdersFromPrefs, []);

  //   salesOrders.value = await getAndSave<SalesOrdersListItem>(
  //       _repository.fetchSalesOrdersFromServer,
  //       [],
  //       parseSalesOrdersListItems,
  //       [],
  //       _prefs.saveSalesOrdersToPrefs,
  //       [],
  //       salesOrders.toList(),
  //       "Getting Sales Orders");

  //   return salesOrders.toList();
  // }

  // final RxList<CustomerStatisticsListItem> customersStatistics =
  //     RxList<CustomerStatisticsListItem>();

  // Future<List<CustomerStatisticsListItem>> getCustomersStatistics() async {
  //   customersStatistics.value = await _prefs
  //       .makeThisOnPrefs<CustomerStatisticsListItem>(
  //           _prefs.loadCustomersStatisticsFromPrefs, []);

  //   customersStatistics.value = await getAndSave<CustomerStatisticsListItem>(
  //       _repository.fetchCustomersStatisticsFromServer,
  //       [],
  //       parseCustomerStatisticsListItems,
  //       [],
  //       _prefs.saveCustomersStatisticsToPrefs,
  //       [],
  //       customersStatistics.toList(),
  //       "Getting Customers Statistics");
  //   return customersStatistics.toList();
  // }

  // final RxList<TopPartsListItem> topParts = RxList<TopPartsListItem>();

  // Future<List<TopPartsListItem>> getTopParts() async {
  //   topParts.value = await _prefs
  //       .makeThisOnPrefs<TopPartsListItem>(_prefs.loadTopPartsFromPrefs, []);

  //   topParts.value = await getAndSave<TopPartsListItem>(
  //       _repository.fetchTopPartsFromServer,
  //       [],
  //       parseTopPartsListItem,
  //       [],
  //       _prefs.saveTopPartsToPrefs,
  //       [],
  //       topParts.toList(),
  //       "Getting Top Parts");
  //   return topParts.toList();
  // }

  // final RxList<AllSalesMonthlyListItem> allSalesMonthly = RxList<AllSalesMonthlyListItem>();

  // Future<List<AllSalesMonthlyListItem>> getAllSalesMonthly() async {
  //   allSalesMonthly.value = await _prefs
  //       .makeThisOnPrefs<AllSalesMonthlyListItem>(_prefs.loadAllSalesMonthlyFromPrefs, []);

  //   allSalesMonthly.value = await getAndSave<AllSalesMonthlyListItem>(
  //       _repository.fetchAllSalesMonthlyFromServer,
  //       [],
  //       parseAllSalesMonthlyListItem,
  //       [],
  //       _prefs.saveAllSalesMonthlyToPrefs,
  //       [],
  //       allSalesMonthly.toList(),
  //       "Getting All Sales Monthly");
  //   return allSalesMonthly.toList();
  // }

  // RxList<CustomerTransactionListItem> mergedAllCustomersTransactions =
  //     RxList<CustomerTransactionListItem>();

  // Future<List<CustomerTransactionListItem>>
  //     getAllCustomersAllTransaction() async {
  //   // await getAllCustomersInvoicesOffers();
  //   await getAllCustomersMoneyTransactions();
  //   await getAllCustomersPartTransactions();
  //   updateAllCustomersMergedTransactions();

  //   return mergedAllCustomersTransactions.toList();
  // }

  // void updateAllCustomersMergedTransactions() {
  //   mergedAllCustomersTransactions.value = [
  //     // ...allCustomersInvoiceOffers,
  //     ...allCustomersMoneyTransactions,
  //     ...allCustomersPartTransactions
  //   ];
  // }
}
