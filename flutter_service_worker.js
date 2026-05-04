'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "8439beb8b1732c0a2985d22d90c57484",
".git/config": "4748976379a23f9405de3b468b4e0c47",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "4cf2d64e44205fe628ddd534e1151b58",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "e0b5b08e209fa15f48d796e8976bc42b",
".git/hooks/fsmonitor-watchman.sample": "5c90c1740b0cacecb469934e16fe8cb6",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "20ec4cfae62971e894be240b722975b7",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "9ed6458925c9bd582744918eae8ff1e9",
".git/logs/refs/heads/master": "9ed6458925c9bd582744918eae8ff1e9",
".git/objects/02/1d4f3579879a4ac147edbbd8ac2d91e2bc7323": "9e9721befbee4797263ad5370cd904ff",
".git/objects/15/ad43602b1778560d5d44d0c43048145e456fd1": "0f5686d0b236984ddec71cf92f210797",
".git/objects/20/3a3ff5cc524ede7e585dff54454bd63a1b0f36": "4b23a88a964550066839c18c1b5c461e",
".git/objects/29/6fd7a5ebe7443f95e530d1041690365cfec6fa": "2513cc57b9079281f154f09d647c5638",
".git/objects/29/f22f56f0c9903bf90b2a78ef505b36d89a9725": "e85914d97d264694217ae7558d414e81",
".git/objects/2e/9cbcbfed4da38a91031e8a38a3439468ff822f": "63e4ef5b01e927051a097e0f9a05b2fe",
".git/objects/40/13f6de1f808bc35b51d47eb631156ed428e98b": "e9b13d80e8a97990be84df1dbeeaa351",
".git/objects/41/8a9f044354a23369cc0a0fbead86e7ee886768": "16bfa7f462c5c00e17d1dda940593513",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/4a/2db9f11a4087dbc45e82b304238dd379a5856e": "cea24c9e26a86b863468cea7d3b92847",
".git/objects/4b/135ba2c445e52a84d9cee7f8e90347fa184775": "4f4c4ec8461fcf9335fe404c566634c1",
".git/objects/4b/dd98c84b838e69565fe2f58ee73a89bf6e8759": "08fb457eda30d21c735987d707bf7510",
".git/objects/4d/bf9da7bcce5387354fe394985b98ebae39df43": "534c022f4a0845274cbd61ff6c9c9c33",
".git/objects/4f/fbe6ec4693664cb4ff395edf3d949bd4607391": "2beb9ca6c799e0ff64e0ad79f9e55e69",
".git/objects/57/9d1f77dd51808f620a78550ebce6d94b8422b4": "329697fa90112bb534b8e57f6af6246b",
".git/objects/5c/b30690643874a7c3032ff68e1890e69b0f0057": "20f957e31330799c9b3bcc67ebb33c86",
".git/objects/5f/07e8a9e6f0083ff32b42f3f3071e6b674617ed": "dba83f51ef2a598043cf7631504727ac",
".git/objects/5f/f4cbf99a067537efbdd5d5e2541b76606441bf": "abd4c2853900ca19bb7d75b147315710",
".git/objects/62/e41d7d5560b09a29fad88a19b86095c00583e9": "9fc68d77f96e6e6559a4cbbb24654e90",
".git/objects/68/6c29a32e0066bbb01c55c0578163a37d0f8d1b": "24d40700d32560a9ea00e533d06403dd",
".git/objects/69/42583190f1a9b015026ae2a66f9bd9e9bde220": "a521f4314e5a91b1693de7d523b3e01c",
".git/objects/6b/9862a1351012dc0f337c9ee5067ed3dbfbb439": "85896cd5fba127825eb58df13dfac82b",
".git/objects/77/08bf37e2ee89a7fc2404b2e63dae5c2427512c": "39f74cc7fc2a5fd0789ba23a67e18758",
".git/objects/7a/6c1911dddaea52e2dbffc15e45e428ec9a9915": "f1dee6885dc6f71f357a8e825bda0286",
".git/objects/7d/6b72ba1a7a455639c93bdfd0497253b03dc65f": "11100622065b5d7197850934012cf881",
".git/objects/7d/922cb66112421f0f19f0822370ffb08f5ba286": "89f014027a3cf7b6d08b9791e8b8363a",
".git/objects/7e/16012f0ba73327a3936cc84020551a2d5dc493": "f898e28fb5ac0acf1e8fc958d3d3c1b6",
".git/objects/87/a15aed0f9fa64ac32a27975efa877c26078b7b": "2d71d306e05058e2da616b7f6bb7fac7",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/98/0195c43a72d76e785774af0904f42d3b4cef3c": "e3e6b33a665a5f4adb60a17d4d2aaa5e",
".git/objects/98/0d49437042d93ffa850a60d02cef584a35a85c": "8e18e4c1b6c83800103ff097cc222444",
".git/objects/9b/3ef5f169177a64f91eafe11e52b58c60db3df2": "91d370e4f73d42e0a622f3e44af9e7b1",
".git/objects/9e/0cfefc580f82b7099856411e91a2ff3bd35386": "5d4121e38eb3719fffdb329fc7726f90",
".git/objects/9e/3b4630b3b8461ff43c272714e00bb47942263e": "accf36d08c0545fa02199021e5902d52",
".git/objects/a3/50f0346b55c8c57105850b6443b9d310d0cae0": "e0687f03d40fbbefcdf92a92103bae8b",
".git/objects/a5/74ab92b430807ed1314a2dc783c577e0196389": "256311c315f161c2db7a5a75aa52706f",
".git/objects/a5/cb415d8f4c804efa1de88b529b95bb7459b6b5": "2a5d5d3742ef7942bd0519addf464c4d",
".git/objects/ae/76d2974a6de46780707a1214464e2520189137": "cc4ba3da855dd1175777ff3e3659c8cf",
".git/objects/b0/d7fbec113e4d9d1ed14e7aaa1d1828989b0272": "02bab0d4d2ee9fb2348cb3adf229db8a",
".git/objects/b6/b8806f5f9d33389d53c2868e6ea1aca7445229": "b14016efdbcda10804235f3a45562bbf",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/c3/5fa1a84f793749e5b3ec569748e8bdacaba590": "0ad422336e9c35bbac2cfc5ae972cd07",
".git/objects/c4/016f7d68c0d70816a0c784867168ffa8f419e1": "fdf8b8a8484741e7a3a558ed9d22f21d",
".git/objects/c8/de301a0b88f9e446056a9d388071832c35bb56": "bddbdda813217e1ab42d8ffc176d1093",
".git/objects/ca/3bba02c77c467ef18cffe2d4c857e003ad6d5d": "316e3d817e75cf7b1fd9b0226c088a43",
".git/objects/cf/7405b58ec94c8ad34f86823361684d27654f30": "49f75802cfbb50ba43730c336e3a4c27",
".git/objects/d2/af564fe0b932471b39a3c399ff344f353c8568": "7a816b16747e066397aea602096c9dbe",
".git/objects/d3/4affe0ccac2a5cf806950abf5d0f24bc897cc6": "c181fbb056a9154745b077264f517fea",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d7/7cfefdbe249b8bf90ce8244ed8fc1732fe8f73": "9c0876641083076714600718b0dab097",
".git/objects/e3/e9ee754c75ae07cc3d19f9b8c1e656cc4946a1": "14066365125dcce5aec8eb1454f0d127",
".git/objects/e4/f9893efb2353515b4e4b45cd379b2f1298537d": "470e556b71a73cefc49e879baa6de676",
".git/objects/e9/94225c71c957162e2dcc06abe8295e482f93a2": "2eed33506ed70a5848a0b06f5b754f2c",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/ed/b55d4deb8363b6afa65df71d1f9fd8c7787f22": "886ebb77561ff26a755e09883903891d",
".git/objects/ef/e26a8364453fbcad243213c5f3b1f5bf326fe1": "b4750c1e3d3d8abb959e9d0709a9425b",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f5/72b90ef57ee79b82dd846c6871359a7cb10404": "e68f5265f0bb82d792ff536dcb99d803",
".git/objects/f8/29d3b4fc49389ec81dec558e4f70b8af0c71db": "57d5f66e2d8e976d37136e15344eb624",
".git/objects/fe/3b987e61ed346808d9aa023ce3073530ad7426": "dc7db10bf25046b27091222383ede515",
".git/refs/heads/master": "f24e2e46e0128d0c53774f46cbabb341",
"assets/AssetManifest.bin": "9ec556ddf30a1308180931e67715a7d0",
"assets/AssetManifest.bin.json": "f07725e4e9f3d14cb5bb23915e21960a",
"assets/AssetManifest.json": "b868a264be21599f5316eb01361bf8df",
"assets/assets/img/alakazam.png": "d9bc851b48770109ae0fbeeb56661f84",
"assets/assets/img/blastoise.png": "cd79065b8e6cd032deeede3e727239aa",
"assets/assets/img/bulbasaur.png": "ba7202bb8f8b50743809422efa6c0144",
"assets/assets/img/charizard.png": "521b2e6d546ed678dce3b565316709ae",
"assets/assets/img/dragonite.png": "a5fb5bd8f00970620e9d44ef2951e5a1",
"assets/assets/img/eevee.png": "5580e07ade60fb33a74a7c99ae59d730",
"assets/assets/img/flareon.png": "92b5450dc85d9995c77c9a85b986c5e3",
"assets/assets/img/gengar.png": "ab6fd0a6c03610d5d4ed03032933d488",
"assets/assets/img/greninja.png": "733f4536fddb29cf5efcc6958615f1ee",
"assets/assets/img/gyarados.png": "a0d4be5670282afb3ee5be779c4a6013",
"assets/assets/img/jolteon.png": "90e9e3190d949aae68e760612516bb75",
"assets/assets/img/lucario.png": "61cecab404a0c84ca609e3e05d321a17",
"assets/assets/img/machamp.png": "a39a16071d3394f9b7222bb2a61f1eef",
"assets/assets/img/pikachu.png": "69e9a38b0e5c777ed073be256aeccdfd",
"assets/assets/img/snorlax.png": "613c9f8a97faee899568ea43cc45c249",
"assets/assets/img/tyranitar.png": "73898069df5007be4749c67cc058c7fd",
"assets/assets/img/vaporeon.png": "09d921872d352fae4d27088457a3a3a9",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "c9b67c16d4c04d42f011b2b45b7e8264",
"assets/NOTICES": "2d9920ddb30eaf878dd6d18e47d4559f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "9184f174d1b9441edb14ecda97a792cd",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "1632a60c8ef1d639c252d3b79ad3d1c7",
"/": "1632a60c8ef1d639c252d3b79ad3d1c7",
"main.dart.js": "21615085ec6b10d22661dff82c252d10",
"manifest.json": "10f9b24c3f0e90a437f81ac4ca77030c",
"version.json": "13438a52bdd3246573cc530ba3156d1c"};
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
