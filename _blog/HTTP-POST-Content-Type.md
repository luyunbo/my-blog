# POST请求的Content-Type
[ZZ] [四种常见的 POST 提交数据方式](https://imququ.com/post/four-ways-to-post-data-in-http.html)

http post请求头Content-Type 被指定为 application/x-www-form-urlencoded；其次，提交的数据按照 key1=val1&key2=val2 的方式进行编码，key 和 val 都进行了 URL 转码。大部分服务端语言都对这种方式有很好的支持。例如 PHP 中，\$\_POST['title'] 可以获取到 title 的值，\$\_POST['sub'] 可以得到 sub 数组。

很多时候，我们用 Ajax 提交数据时，也是使用这种方式。 JQuery和的 Ajax，Content-Type 默认值都是「application/x-www-form-urlencoded;charset=utf-8」。

当请求头中 Content-Type 为 application/json 时,php就无法通过 \$\_POST 对象从post请求中获得json内容。这时候，需要自己动手处理下：，从 php://input 里获得原始输入流，再 json_decode 成对象。
