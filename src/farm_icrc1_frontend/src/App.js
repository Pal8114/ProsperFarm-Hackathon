// import logo from './logo.svg';
// import './App.css';

// function App() {
  // return (
    // <div className="App">
      // <header className="App-header">
        // <img src={logo} className="App-logo" alt="logo" />
        // <p>
          // Edit <code>src/App.js</code> and save to reload.
        // </p>
        // <a
          // className="App-link"
          // href="https://reactjs.org"
          // target="_blank"
          // rel="noopener noreferrer"
        // >
          // Learn React
        // </a>
      // </header>
    // </div>
  // );
// }

import React, { useState, useEffect }  from "react";
import Unity, { UnityContext } from "react-unity-webgl";

const unityContext = new UnityContext({
  loaderUrl: "Build/prosperfarm.loader.js", // public下目录
  dataUrl: "Build/prosperfarm.data.gz",
  frameworkUrl: "Build/prosperfarm.framework.js.gz",
  codeUrl: "Build/prosperfarm.wasm.gz",
});

function App() {
  useEffect(function () {

//     unityContext.on("Login", function () { // 监听Login事件
// 		    loginSuccessCallback("Testplayer001");
//     });

    unityContext.on("pullSaved", function () { // 监听pullSaved事件
    OnPullSaved("Testplayer001", "{}");
     });

    unityContext.on("pushSaved", function (savedata) { // 监听pushSaved事件
    });
  }, []);
  
  // function loginSuccessCallback(uid) {
  //   unityContext.send("ReactWrapper", "LoginSuccessCallback", uid);
  // }

  function OnPullSaved(uid, savedata) {
    console.log("OnPullSaved " + uid + " " + savedata);
    unityContext.send("ReactWrapper", "OnPullSaved", uid, savedata);
  }

  // 一定要给Unity组件设置width和height属性，否则Canvas将无限增大最终导致浏览器卡死
  return <Unity style={{'width': '100%', 'height': '100%'}} unityContext={unityContext} />;
}


export default App;
