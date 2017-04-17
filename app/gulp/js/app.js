/* eslint no-unused-vars: off */
// Put javascript that should be included in every page of the app here
// Note also that all .js files in this directory will be combined by gulp
window.noLive = true;

function onPage(controller, action, fn) {
  $().ready(() => {
    if (document.getElementById(`${controller}-${action}`)) {
      fn();
    }
  });
}

function checkForLiveQuestion() {
  if (window.noLive) {
    $.ajax({ url: '/check_live_question',
      success: (qpage) => {
        if (qpage) {
          $.ajax({ url: '/get_popup_html',
            success: (modal) => {
              const complete = modal.replace('aaaaaa', qpage);
              $('#modal-window').html(complete);
              window.noLive = false;
              $('#modal-window').modal();
            } });
        }
      } });
  }
}

setInterval(checkForLiveQuestion, 5000);
