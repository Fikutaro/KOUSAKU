$(document).on 'turbolinks:load', ->
  $('[data-provider="summernote"]').each ->
    $(this).summernote
      height: 400
      lang: "ja-JP",
      placeholder: "本文をこちらに記入してください。<br>番号リストや画像を入れることもできます。",
      fontSizes:['10', '11', '12', '13','14', '18', '24', '36'],
      toolbar: [
                ["style", ["style"]],
                ["fontsize", ["fontsize"]],
                ["color", ["color"]],
                ["style", ["bold", "italic", "underline", "clear"]],
                ['table', ['table']],
                ["para", ["ul", "ol", "paragraph"]],
                ["height", ["height"]],
                ['insert', ['picture', 'link']],
                 ['view', ['help']],
      ]

