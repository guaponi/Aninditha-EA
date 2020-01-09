//+------------------------------------------------------------------+
//|                                                 Aninditha-EA.mq5 |
//|                              Copyright 2020, Harold and Siswandy |
//+------------------------------------------------------------------+

//External Script
#include "script\Testing.mqh";
#include "script\Analyzer.mqh";
#include "script\Manage.mqh";
#include "script\Calculate.mqh";
#include "script\Execute.mqh";

//Class Object
Analyzer AninAnalyze;
Manager AninManage;
Calculate AninCalculate;
Execute AninExecute;
Testing test;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {

   Print("Hi I'm Aninditha, your friend in FX Market");

   //test.printTest();

   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
   Print("Shut down");
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick() {

   string signal = AninAnalyze.signal();
   Comment(signal);

   bool access = AninManage.access();
   

   if(access == true) {
      access = false;//reset value
      double volume = AninCalculate.lotSize();

      //TODO Update the comment format
      if(signal == "buy") {
         double entryPoint = AninCalculate.askPrice();
         double stopLoss = AninCalculate.stopLoss(signal, entryPoint);
         double takeProfit = AninCalculate.takeProfit(signal, entryPoint);
         string comment =
            "Buy. Price:" + DoubleToString(NormalizeDouble(entryPoint,4)) + " , " +
            "Volume:" + DoubleToString(volume) + " , " +
            "SL:" + DoubleToString(NormalizeDouble(stopLoss, 4)) + " , " +
            "TP:" + DoubleToString(NormalizeDouble(takeProfit,4));

         //Print(comment);
         AninExecute.instantBuy(volume,entryPoint, stopLoss, takeProfit, comment);
      }
      if(signal == "sell") {
         double entryPoint = AninCalculate.bidPrice();
         double stopLoss = AninCalculate.stopLoss(signal, entryPoint);
         double takeProfit = AninCalculate.takeProfit(signal, entryPoint);
         string comment =
            "Buy. Price:" + DoubleToString(NormalizeDouble(entryPoint,4)) + " , " +
            "Volume:" + DoubleToString(volume) + " , " +
            "SL:" + DoubleToString(NormalizeDouble(stopLoss, 4)) + " , " +
            "TP:" + DoubleToString(NormalizeDouble(takeProfit,4));

         //Print(comment);
         AninExecute.instantSell(volume,entryPoint, stopLoss, takeProfit, comment);
      }
   }
}
//+------------------------------------------------------------------+
