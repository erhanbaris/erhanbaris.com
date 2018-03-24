---
title: SonOff Basic Wifi Kurulumu
tags:
 - SonOff Wifi
 - Akıllı Ev
---
Evde ki prizleri ve ışıkları uzaktan kontrol edilebilir hale getirmek ile ilgili küçük bir düşüncemin sonucunda internetten **SonOff Basic Wifi Smart Swich** isimli devreyi satın aldım. 

## Son kullanıcı kurulumu
Kabloları bağladıktan sonra telefonunuza EWeLink isimli uygulamayı kurmanız gerekiyor. Bu uygulama ile internet üzerinden devreyi açıp kapatabilirsiniz.

Cihazın üzerinde ki tuşa 7 saniye basılı tutun sonra bırakın, tekrardan 7 saniye basılı tutun ve bırakın. Bu işlem sonucunda Wifi listesinde **ITEAD-** ile başlayan bir bağlantı olması gerekiyor. Ona bağlanın, şifresi **12345678** girin.



## Uzmanlar için kurulum ve ayarlar
Bilgisayarınızdan önceden söylediğim adımları yaparak cihaza bağlanın. Bağlantı başarılı olup olmadığını kontrol etmek için **http://10.10.7.1/device** linkine girin.
Yada komut satırından;
{% codeblock %}
curl http://10.10.7.1/device
{% endcodeblock %}

Eğer aşağıda ki ne benzer bir sonuç elde ederseniz sorunsuz bağlandınız demektir.

{% gist erhanbaris/588e23f367a8612142fc25359278c4bb response %}

data.json dosyası aşağıda ki gibi

{% gist erhanbaris/588e23f367a8612142fc25359278c4bb data.json %}

{% codeblock %}
curl -d "@data.json" -X POST http://10.10.7.1/ap
{% endcodeblock %}
