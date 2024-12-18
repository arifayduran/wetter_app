'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"main.dart.js": "1419872a93a84fbccc35c94214729f41",
"assets/FontManifest.json": "9f9f8613fd8f8a29927a22049684ffe5",
"assets/AssetManifest.bin": "10b231595cb07486e15fa582879e439a",
"assets/fonts/MaterialIcons-Regular.otf": "0db35ae7a415370b89e807027510caf0",
"assets/packages/flutter_sficon/lib/fonts/sficons.ttf": "169c2d0478acf6f513abe01a313c0e0d",
"assets/assets/Wetter%2520an%2520meinem%2520Standort%2520anzeigen.jpeg": "7c52b25324e2223492f2b031f88584cd",
"assets/assets/IMG_2038.PNG": "ef46b0db4adb5e9c874ff9cbecddc646",
"assets/assets/images/rain.png": "451d37e6cea3af4a568110863a1adcf7",
"assets/assets/images/cloudynightpartly.png": "17cc1a8a95028b89ba6988ee47eeab29",
"assets/assets/images/NA.png": "729f934e3b18d394b152b349483288da",
"assets/assets/images/icon.png": "9cf3f2d18fec484113ffdf5433e3b3e2",
"assets/assets/images/partlycloudy.png": "67aaf9dbe30989c25cbde6c6ec099213",
"assets/assets/images/clearnight.png": "1200cde3569cf69bd80e1ddabc0f15cd",
"assets/assets/images/sunset.png": "791abf4ca2e11cf399b0d98c5e28598a",
"assets/assets/images/heavyrain.png": "451d37e6cea3af4a568110863a1adcf7",
"assets/assets/images/sunrise.png": "78606be71a30b2e518815e252a93cbb1",
"assets/assets/images/wolken_card.jpeg": "ab4bd5c5f03df69860ae857b447a5ffe",
"assets/assets/images/cloudy.png": "66117fab0f288a2867b340fa2fcde31b",
"assets/assets/images/sun.png": "575900edccbc7def167f7874c02aeb0b",
"assets/assets/images/rainynight.png": "d4b6596291c114305b64056bd92ccee3",
"assets/assets/videos/cloudynight.mov": "e6f1e5271184868e4a3c7cb2d70a9276",
"assets/assets/videos/bewolkt.mov": "8eaaf148d8f4a23abc8570004c360694",
"assets/assets/videos/sunny.mov": "c41971e3c065b8a4965e68017db0d0be",
"assets/assets/videos/black.mp4": "3d139b3c7953240520054f3515b981ea",
"assets/assets/videos/rainynight.mov": "e5edf66a44de6d338e0afa4f047bfab0",
"assets/assets/videos/regentag.mov": "c6059dd8983de7efb70b4c842e733a48",
"assets/NOTICES": "56674e3dcc7e051042df6f73f4869ebc",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.json": "4b4c25c85e7f5bea431e0ecb1915e355",
"assets/AssetManifest.bin.json": "1801fca2a6cdb5ec34b98f213b37ddee",
"index.html": "8c61aad33e816d5ea108b4d3dcce8d8b",
"/": "8c61aad33e816d5ea108b4d3dcce8d8b",
"manifest.json": "80c986b4ca7ffd4af70b014c9704ba1b",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"icons/Icon-maskable-192.png": "1e6e9d6b204bc46e4572f14e4e015307",
"icons/Icon-192.png": "1e6e9d6b204bc46e4572f14e4e015307",
"icons/Icon-512.png": "a4a47542e8dd751a4905243fe7d3e64e",
"icons/Icon-maskable-512.png": "a4a47542e8dd751a4905243fe7d3e64e",
"favicon.png": "ea4e133f87b9ad7e106bf0d20c585899",
"version.json": "df79ab2ae69c7807f3aab7a4720f1c37",
"flutter_bootstrap.js": "b222f645f496bd93cae977362a25c7aa"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
