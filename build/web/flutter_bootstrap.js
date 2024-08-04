const shadcnLoaderConfig = {
    loaderWidget: `
        <div style="text-align: center; font-smooth: always; display: flex; flex-direction: column; align-items: center">
            <svg id="hexagon" viewBox="0 0 100 100" width="120" height="120">
                <path d="M50 5 L90 25 L90 75 L50 95 L10 75 L10 25 Z" fill="none" stroke="#3c83f6" stroke-width="4"/>
                <text id="H" x="50%" y="50%" fill="#3c83f6" font-size="24" font-family="Geist Sans, sans-serif" text-anchor="middle" alignment-baseline="middle" opacity="0" font-weight="bold">H</text>
            </svg>
        </div>`,
    backgroundColor: '#09090b',
    foregroundColor: '#ffffff',
    loaderColor: '#3c83f6',
    fontFamily: 'Geist Sans, sans-serif',
    fontSize: '24px',
    fontWeight: '400',
    mainAxisAlignment: 'center',
    crossAxisAlignment: 'center',
    externalScripts: [
        {
            src: 'https://cdn.jsdelivr.net/npm/@fontsource/geist-sans@5.0.3/400.min.css',
            type: 'stylesheet',
        },
        {
            src: 'https://cdn.jsdelivr.net/npm/@fontsource/geist-sans@5.0.3/300.min.css',
            type: 'stylesheet',
        },
        {
            src: 'https://cdnjs.cloudflare.com/ajax/libs/animejs/3.2.1/anime.min.js',
            type: 'script',
        }
    ]
};

function getSharedPreferences() {
    let sharedPreferences = {};
    // Get all items from localStorage that start with 'flutter.'
    for (let key in localStorage) {
        if (key.startsWith('flutter.')) {
            let sharedPreferencesKey = key.substring(8);
            sharedPreferences[sharedPreferencesKey] = localStorage.getItem(key);
        }
    }
    return sharedPreferences;
}

(()=>{var I=()=>navigator.vendor==="Google Inc."||navigator.agent==="Edg/",T=()=>typeof ImageDecoder>"u"?!1:I(),E=()=>typeof Intl.v8BreakIterator<"u"&&typeof Intl.Segmenter<"u",S=()=>{let o=[0,97,115,109,1,0,0,0,1,5,1,95,1,120,0];return WebAssembly.validate(new Uint8Array(o))},p={hasImageCodecs:T(),hasChromiumBreakIterators:E(),supportsWasmGC:S(),crossOriginIsolated:window.crossOriginIsolated};var w=U(L());function L(){let o=document.querySelector("base");return o&&o.getAttribute("href")||""}function U(o){return o===""||o.endsWith("/")?o:`${o}/`}var f=class{constructor(){this._scriptLoaded=!1}setTrustedTypesPolicy(e){this._ttPolicy=e}async loadEntrypoint(e){let{entrypointUrl:n=`${w}main.dart.js`,onEntrypointLoaded:r,nonce:t}=e||{};return this._loadJSEntrypoint(n,r,t)}async load(e,n,r,t,i){if(i??=s=>{s.initializeEngine(r).then(a=>a.runApp())},e.compileTarget==="dart2wasm")return this._loadWasmEntrypoint(e,n,i);{let s=e.mainJsPath??"main.dart.js",a=`${w}${s}`;return this._loadJSEntrypoint(a,i,t)}}didCreateEngineInitializer(e){typeof this._didCreateEngineInitializerResolve=="function"&&(this._didCreateEngineInitializerResolve(e),this._didCreateEngineInitializerResolve=null,delete _flutter.loader.didCreateEngineInitializer),typeof this._onEntrypointLoaded=="function"&&this._onEntrypointLoaded(e)}_loadJSEntrypoint(e,n,r){let t=typeof n=="function";if(!this._scriptLoaded){this._scriptLoaded=!0;let i=this._createScriptTag(e,r);if(t)console.debug("Injecting <script> tag. Using callback."),this._onEntrypointLoaded=n,document.head.append(i);else return new Promise((s,a)=>{console.debug("Injecting <script> tag. Using Promises. Use the callback approach instead!"),this._didCreateEngineInitializerResolve=s,i.addEventListener("error",a),document.head.append(i)})}}async _loadWasmEntrypoint(e,n,r){if(!this._scriptLoaded){this._scriptLoaded=!0,this._onEntrypointLoaded=r;let{mainWasmPath:t,jsSupportRuntimePath:i}=e,s=`${w}${t}`,a=`${w}${i}`;this._ttPolicy!=null&&(a=this._ttPolicy.createScriptURL(a));let d=WebAssembly.compileStreaming(fetch(s)),c=await import(a),u;e.renderer==="skwasm"?u=(async()=>{let m=await n.skwasm;return window._flutter_skwasmInstance=m,{skwasm:m.wasmExports,skwasmWrapper:m,ffi:{memory:m.wasmMemory}}})():u={};let l=await c.instantiate(d,u);await c.invoke(l)}}_createScriptTag(e,n){let r=document.createElement("script");r.type="application/javascript",n&&(r.nonce=n);let t=e;return this._ttPolicy!=null&&(t=this._ttPolicy.createScriptURL(e)),r.src=t,r}};async function b(o,e,n){if(e<0)return o;let r,t=new Promise((i,s)=>{r=setTimeout(()=>{s(new Error(`${n} took more than ${e}ms to resolve. Moving on.`,{cause:b}))},e)});return Promise.race([o,t]).finally(()=>{clearTimeout(r)})}var h=class{setTrustedTypesPolicy(e){this._ttPolicy=e}loadServiceWorker(e){if(!e)return console.debug("Null serviceWorker configuration. Skipping."),Promise.resolve();if(!("serviceWorker"in navigator)){let a="Service Worker API unavailable.";return window.isSecureContext||(a+=`
The current context is NOT secure.`,a+=`
Read more: https://developer.mozilla.org/en-US/docs/Web/Security/Secure_Contexts`),Promise.reject(new Error(a))}let{serviceWorkerVersion:n,serviceWorkerUrl:r=`${w}flutter_service_worker.js?v=${n}`,timeoutMillis:t=4e3}=e,i=r;this._ttPolicy!=null&&(i=this._ttPolicy.createScriptURL(i));let s=navigator.serviceWorker.register(i).then(a=>this._getNewServiceWorker(a,n)).then(this._waitForServiceWorkerActivation);return b(s,t,"prepareServiceWorker")}async _getNewServiceWorker(e,n){if(!e.active&&(e.installing||e.waiting))return console.debug("Installing/Activating first service worker."),e.installing||e.waiting;if(e.active.scriptURL.endsWith(n))return console.debug("Loading from existing service worker."),e.active;{let r=await e.update();return console.debug("Updating service worker."),r.installing||r.waiting||r.active}}async _waitForServiceWorkerActivation(e){if(!e||e.state==="activated")if(e){console.debug("Service worker already active.");return}else throw new Error("Cannot activate a null service worker!");return new Promise((n,r)=>{e.addEventListener("statechange",()=>{e.state==="activated"&&(console.debug("Activated new service worker."),n())})})}};var v=class{constructor(e,n="flutter-js"){let r=e||[/\.js$/,/\.mjs$/];window.trustedTypes&&(this.policy=trustedTypes.createPolicy(n,{createScriptURL:function(t){if(t.startsWith("blob:"))return t;let i=new URL(t,window.location),s=i.pathname.split("/").pop();if(r.some(d=>d.test(s)))return i.toString();console.error("URL rejected by TrustedTypes policy",n,":",t,"(download prevented)")}}))}};var y=o=>{let e=WebAssembly.compileStreaming(fetch(o));return(n,r)=>((async()=>{let t=await e,i=await WebAssembly.instantiate(t,n);r(i,t)})(),{})};var C=(o,e,n,r)=>window.flutterCanvasKit?Promise.resolve(window.flutterCanvasKit):(window.flutterCanvasKitLoaded=new Promise((t,i)=>{let s=n.hasChromiumBreakIterators&&n.hasImageCodecs;if(!s&&e.canvasKitVariant=="chromium")throw"Chromium CanvasKit variant specifically requested, but unsupported in this browser";let a=s&&e.canvasKitVariant!=="full",d=e.canvasKitBaseUrl??`https://www.gstatic.com/flutter-canvaskit/${r}/`;a&&(d=`${d}chromium/`);let c=`${d}canvaskit.js`;o.flutterTT.policy&&(c=o.flutterTT.policy.createScriptURL(c));let u=y(`${d}canvaskit.wasm`),l=document.createElement("script");l.src=c,e.nonce&&(l.nonce=e.nonce),l.addEventListener("load",async()=>{try{let m=await CanvasKitInit({instantiateWasm:u});window.flutterCanvasKit=m,t(m)}catch(m){i(m)}}),l.addEventListener("error",i),document.head.appendChild(l)}),window.flutterCanvasKitLoaded);var _=(o,e,n,r)=>new Promise((t,i)=>{let s=e.canvasKitBaseUrl??`https://www.gstatic.com/flutter-canvaskit/${r}/`,a=`${s}skwasm.js`;o.flutterTT.policy&&(a=o.flutterTT.policy.createScriptURL(a));let d=y(`${s}skwasm.wasm`),c=document.createElement("script");c.src=a,e.nonce&&(c.nonce=e.nonce),c.addEventListener("load",async()=>{try{let u=await skwasm({instantiateWasm:d,locateFile:(l,m)=>{let k=m+l;return k.endsWith(".worker.js")?URL.createObjectURL(new Blob([`importScripts('${k}');`],{type:"application/javascript"})):k}});t(u)}catch(u){i(u)}}),c.addEventListener("error",i),document.head.appendChild(c)});var g=class{async loadEntrypoint(e){let{serviceWorker:n,...r}=e||{},t=new v,i=new h;i.setTrustedTypesPolicy(t.policy),await i.loadServiceWorker(n).catch(a=>{console.warn("Exception while loading service worker:",a)});let s=new f;return s.setTrustedTypesPolicy(t.policy),this.didCreateEngineInitializer=s.didCreateEngineInitializer.bind(s),s.loadEntrypoint(r)}async load({serviceWorkerSettings:e,onEntrypointLoaded:n,nonce:r,config:t}={}){t??={};let i=_flutter.buildConfig;if(!i)throw"FlutterLoader.load requires _flutter.buildConfig to be set";let s=l=>{switch(l){case"skwasm":return p.crossOriginIsolated&&p.hasChromiumBreakIterators&&p.hasImageCodecs&&p.supportsWasmGC;default:return!0}},a=l=>l.compileTarget==="dart2wasm"&&!p.supportsWasmGC||t.renderer&&t.renderer!=l.renderer?!1:s(l.renderer),d=i.builds.find(a);if(!d)throw"FlutterLoader could not find a build compatible with configuration and environment.";let c={};c.flutterTT=new v,e&&(c.serviceWorkerLoader=new h,c.serviceWorkerLoader.setTrustedTypesPolicy(c.flutterTT.policy),await c.serviceWorkerLoader.loadServiceWorker(e).catch(l=>{console.warn("Exception while loading service worker:",l)})),d.renderer==="canvaskit"?c.canvasKit=C(c,t,p,i.engineRevision):d.renderer==="skwasm"&&(c.skwasm=_(c,t,p,i.engineRevision));let u=new f;return u.setTrustedTypesPolicy(c.flutterTT.policy),this.didCreateEngineInitializer=u.didCreateEngineInitializer.bind(u),u.load(d,c,t,r,n)}};window._flutter||(window._flutter={});window._flutter.loader||(window._flutter.loader=new g);})();
//# sourceMappingURL=flutter.js.map

if (!window._flutter) {
  window._flutter = {};
}
_flutter.buildConfig = {"engineRevision":"edd8546116457bdf1c5bdfb13ecb9463d2bb5ed4","builds":[{"compileTarget":"dart2js","renderer":"auto","mainJsPath":"main.dart.js"}]};


const loaderStyle = `
    display: flex;
    justify-content: ${shadcnLoaderConfig.mainAxisAlignment};
    align-items: ${shadcnLoaderConfig.crossAxisAlignment};
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: ${shadcnLoaderConfig.backgroundColor};
    color: ${shadcnLoaderConfig.foregroundColor};
    z-index: 9998;
    font-family: ${shadcnLoaderConfig.fontFamily};
    font-size: ${shadcnLoaderConfig.fontSize};
    font-weight: ${shadcnLoaderConfig.fontWeight};
    text-align: center;
    transition: opacity 0.5s;
    opacity: 1;
    pointer-events: initial;
`;

const loaderBarCss = `
/* HTML: <div class="loader"></div> */
.loader {
  height: 7px;
  background: repeating-linear-gradient(-45deg,${shadcnLoaderConfig.loaderColor} 0 15px,#000 0 20px) left/200% 100%;
  animation: l3 10s infinite linear;
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 9999;
}
@keyframes l3 {
    100% {background-position:right}
}`;

function createStyleSheet(css) {
    const style = document.createElement('style');
    style.type = 'text/css';
    style.appendChild(document.createTextNode(css));
    document.head.appendChild(style);
}

function loadScriptDynamically(src, callback) {
    if (typeof src === 'string') {
        src = { src: src, type: 'script' };
    }
    if (src.type === 'script') {
        const script = document.createElement('script');
        script.src = src.src;
        script.onload = callback;
        document.body.appendChild(script);
    } else if (src.type === 'module') {
        const script = document.createElement('script');
        script.type = 'module';
        script.src = src.src;
        script.onload = callback;
        document.body.appendChild(script);
    } else if (src.type === 'stylesheet') {
        const link = document.createElement('link');
        link.rel = 'stylesheet';
        link.href = src.src;
        link.onload = callback;
        document.head.appendChild(link);
    } else {
        throw new Error('Unknown type of file to load: ' + src);
    }
}

const loaderDiv = document.createElement('div');
loaderDiv.style.cssText = loaderStyle;
loaderDiv.innerHTML = shadcnLoaderConfig.loaderWidget;

document.body.appendChild(loaderDiv);
document.body.style.backgroundColor = shadcnLoaderConfig.backgroundColor;

const loaderBarDiv = document.createElement('div');
loaderBarDiv.className = 'loader';
loaderDiv.appendChild(loaderBarDiv);

createStyleSheet(loaderBarCss);

window.onAppReady = function() {
    loaderDiv.style.opacity = 0;
    loaderDiv.style.pointerEvents = 'none';
};

function loadExternalScripts(index, onDone) {
    if (index >= shadcnLoaderConfig.externalScripts.length) {
        onDone();
        return;
    }
    loadScriptDynamically(shadcnLoaderConfig.externalScripts[index], () => {
        loadExternalScripts(index + 1, onDone);
    });
}

function loadApp() {
    let externalScriptIndex = 0;
    loadExternalScripts(externalScriptIndex, () => {
        _flutter.loader.load({
            onEntrypointLoaded: async function(engineInitializer) {
                const appRunner = await engineInitializer.initializeEngine();
                await appRunner.runApp();
            }
        });

        // Initialize the anime.js animation
        anime.timeline({ loop: true, direction: 'alternate' })
            .add({
                targets: '#hexagon path',
                strokeDashoffset: [anime.setDashoffset, 0],
                easing: 'easeInOutQuart',
                duration: 1500,
                delay: function(el, i) { return i * 200; },
            })
            .add({
                targets: '#hexagon #H',
                duration: 800,
                opacity: 1,
                easing: 'easeInOutQuart'
            });
    });
}

loadApp();
