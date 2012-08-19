$(document).ready(function() {
  $('#file-uploader').on('change', function(e) {
    e.preventDefault();
    $(this).ajaxSubmit({
      beforeSubmit:  showFileRequest,
      success:       showFileResponse
    })
  });

  $('#description-uploader').ajaxForm();
});

var percentage;

function showFileRequest(formData, jqForm, options) {
  options.url = window.location.protocol + "//" + window.location.host + '/files/' + guidGenerator(formData);
  $('#file').attr('disabled', 'disabled');
  $('#description-uploader textarea').val('');
  $('#description-uploader input').attr('disabled', 'disabled');
  $('#file-link a').remove();
  $('#file-uploader').attr('action', '/files/' + guidGenerator(formData));
  $('#description-uploader').attr('action', '/files/' + guidGenerator(formData) + '/description');

  (function getPercentage(){
    $.ajax({
      url: '/files/' + guidGenerator(formData) + '/uploaded-percentage'
    }).done(function(percentage) {
      $('#percentage').text(percentage);
    });
    percentage = setTimeout(getPercentage, 1000);
    })();
    return true;
  }

  function showFileResponse(responseText, statusText, xhr, $form)  {
    if (statusText == 'success') {
      $('#description-uploader input').removeAttr('disabled');
      $('#percentage').text(100);
      $('#file').removeAttr('disabled');
      $.ajax({
        url: $form[0].action
      }).done(function(path) {
        $('#file-link').html  ('<a href="' + path + '">Uploaded to Here</a>');
      });
    }
    clearTimeout(percentage);
  }

  function guidGenerator(formData) {
    return formData[0].value.name + '_' + formData[0].value.size;
  }
