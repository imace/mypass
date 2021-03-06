BROWSERIFY=node_modules/.bin/browserify
SRC=src/popup.coffee src/ui.coffee src/passwdgen.coffee src/standalone.coffee src/popup.coffee
JSMIN=uglifyjs -c -m

all: bundle

bundle:
	cake build
	$(BROWSERIFY) build/popup.js -o Chrome/js/popup-bundle.js
	$(BROWSERIFY) build/options.js -o options-bundle.js
	cp options-bundle.js Chrome/js/
	mv options-bundle.js mypass.safariextension/js/
	$(BROWSERIFY) build/global.js -o mypass.safariextension/js/global-bundle.js
	$(BROWSERIFY) build/popover.js -o mypass.safariextension/js/popover-bundle.js
	$(BROWSERIFY) build/standalone.js -o html/js/standalone-bundle.js
	$(BROWSERIFY) build/ios.js -o html/js/ios-bundle.js

production:
	cake build
	$(BROWSERIFY) build/popup.js | $(JSMIN) > Chrome/js/popup-bundle.js
	$(BROWSERIFY) build/options.js | $(JSMIN) > options-bundle.js
	cp options-bundle.js Chrome/js/
	mv options-bundle.js mypass.safariextension/js/
	$(BROWSERIFY) build/global.js | $(JSMIN) > mypass.safariextension/js/global-bundle.js
	$(BROWSERIFY) build/popover.js | $(JSMIN) > mypass.safariextension/js/popover-bundle.js
	$(BROWSERIFY) build/standalone.js | $(JSMIN) > html/js/standalone-bundle.js
	$(BROWSERIFY) build/ios.js | $(JSMIN) > html/js/ios-bundle.js

clean:
	rm -rf build
