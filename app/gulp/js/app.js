/* eslint no-unused-vars: off */
// Put javascript that should be included in every page of the app here
// Note also that all .js files in this directory will be combined by gulp

function onPage(controller, action, fn) {
  $().ready(() => {
    if (document.getElementById(`${controller}-${action}`)) {
      fn();
    }
  });
}
