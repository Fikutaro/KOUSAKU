sendFile = (file, toSummernote) ->
  data = new FormData
  data.append 'upload[image]', file
  $.ajax
    data: data
    type: 'POST'
    url: '/uploads'
    cache: false
    contentType: false
    processData: false
    success: (data) ->
      img = document.createElement('IMG')
      img.src = data.url
      console.log data
      img.setAttribute('id', "sn-image-#{data.upload_id}")
      toSummernote.summernote 'insertNode', img

deleteFile = (file_id) ->
  $.ajax
    type: 'DELETE'
    url: "/uploads/#{file_id}"
    cache: false
    contentType: false
    processData: false

# 画像は別モデルで保存

$(document).on 'turbolinks:load', ->
  $('[data-provider="summernote"]').each ->
    $(this).summernote
      lang: 'ja-JP'
      height: 400
      callbacks:
        onImageUpload: (files) ->
          sendFile files[0], $(this)
        onMediaDelete: (target, editor, editable) ->
          upload_id = target[0].id.split('-').slice(-1)[0]
          console.log upload_id
          if !!upload_id
            deleteFile upload_id
          target.remove()
      placeholder: "本文をこちらに記入してください。<br>画像を入れることもできます。",
      fontSizes:["10", "11", "12", "13","14", "16", "18", "24", "36"],
      toolbar: [
                ["style", ["style"]],
                ["fontsize", ["fontsize"]],
                ["color", ["color"]],
                ["style", ["bold", "italic", "underline","strikethrough","clear"]],
                ["para", ["paragraph"]],
                ["height", ["height"]],
                ["insert", ["picture", "link"]],
                ["view", ["undo","redo","fullscreen"]],
                ["view", ["help"]]
                # helpのみ2行目にしたいため、分けて記入
                ]
