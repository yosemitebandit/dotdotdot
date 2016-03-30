$([IPython.events]).on('app_initialized.NotebookApp', function(){
  IPython.CodeCell.options_default['cm_config']['indentUnit'] = 2;
});
