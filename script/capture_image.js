var page = require('webpage').create();
var system = require('system');
var address, output, size;

if (system.args.length != 3) {
  console.log('Usage: capture.js URL filename');
  phantom.exit(1);
} else {
  address = system.args[1];
  output = system.args[2];
  page.viewportSize = { width: 600, height: 600 };
  page.open(address, function (status) {
    if (status !== 'success') {
      console.log('Unable to load the address!');
      phantom.exit();
    } else {
      page.evaluate(function() {
        try { document.body.bgColor = 'white'; } catch(err) { }
        try { document.body.style.background = 'white'; } catch(err) { }
      });
      window.setTimeout(function () {
        page.render(output);
        phantom.exit();
      }, 200);
    }
  });
}
