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

{{flutter_js}}
{{flutter_build_config}}

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
