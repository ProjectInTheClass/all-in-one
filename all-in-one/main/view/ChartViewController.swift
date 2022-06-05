//
//  ChartViewController.swift
//  all-in-one
//
//  Created by 박현준 on 2022/06/04.
//

import UIKit
import WebKit

class ChartViewController: UIViewController,WKUIDelegate,WKNavigationDelegate {
    var widgetStr =
        """
        <div class="tradingview-widget-container">
          <div id="tradingview_5a89e"></div>
          <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
          <script type="text/javascript">
          new TradingView.MediumWidget(
          {
          "symbols": [
            [
              "--symbol--"
            ]
          ],
          "chartOnly": false,
          "width": 1000,
          "height": 800,
          "locale": "kr",
          "colorTheme": "light",
          "isTransparent": false,
          "autosize": false,
          "showVolume": false,
          "hideDateRanges": false,
          "scalePosition": "right",
          "scaleMode": "Normal",
          "fontFamily": "-apple-system, BlinkMacSystemFont, Trebuchet MS, Roboto, Ubuntu, sans-serif",
          "noTimeScale": false,
          "valuesTracking": "1",
          "chartType": "line",
          "fontColor": "#787b86",
          "gridLineColor": "rgba(42, 46, 57, 0.06)",
          "container_id": "tradingview_5a89e"
        }
          );
          </script>
        </div>
        <div class="tradingview-widget-container">
          <div class="tradingview-widget-container__widget"></div>
          <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-technical-analysis.js" async>
          {
          "interval": "1m",
          "width": 1000,
          "isTransparent": false,
          "height": 800,
          "symbol": "--symbol--",
          "showIntervalTabs": true,
          "locale": "kr",
          "colorTheme": "light"
        }
          </script>
        </div>
        """
    
    @IBOutlet weak var webView: WKWebView!

    var ticker: String?
    @IBOutlet weak var textLabel: UILabel!
    
    override func loadView() {
        super.loadView()
        webView = WKWebView(frame: self.view.frame)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        self.view = self.webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() } //모달창 닫힐때 앱 종료현상 방지.
        
        //alert 처리
        func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String,
                     initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void){
            let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in completionHandler() }))
            self.present(alertController, animated: true, completion: nil)
        }

        //confirm 처리
        func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
            let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: { (action) in completionHandler(false) }))
            alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in completionHandler(true) }))
            self.present(alertController, animated: true, completion: nil)
        }
        
        // href="_blank" 처리
        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if navigationAction.targetFrame == nil { webView.load(navigationAction.request) }
            return nil
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        widgetStr = widgetStr.replacingOccurrences(of: "--symbol--", with: ticker ?? "")
        webView.loadHTMLString(widgetStr, baseURL: nil)
    }
}
