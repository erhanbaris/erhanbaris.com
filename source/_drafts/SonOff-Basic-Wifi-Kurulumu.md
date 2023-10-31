---
title: SonOff Basic Wifi Kurulumu
lang: tr
tags:
  - SonOff Wifi Switch
  - Akıllı Ev
  - eWeLink
date: 2018-03-25 00:22:26
---

Evde ki prizleri ve ışıkları uzaktan kontrol edilebilir hale getirmek ile ilgili küçük bir düşüncemin sonucunda internetten **SonOff Basic Wifi Smart Swich** isimli devreyi satın aldım.

Kabloları bağladıktan sonra telefonunuza eWeLink isimli uygulamayı kurmanız gerekiyor. Bu uygulama ile internet üzerinden devreyi açıp kapatabilirsiniz.
{% link "IOS linki" https://itunes.apple.com/us/app/ewelink-smart-home-control/id1035163158?mt=8 %}
{% link "Android linki" https://play.google.com/store/apps/details?id=com.coolkit&hl=tr %}

Cihazın üzerinde ki tuşa 7 saniye basılı tutun sonra bırakın, tekrardan 7 saniye basılı tutun ve bırakın. Bu işlem sonucunda telefonunuzdan bulunan Wifi listesinde **ITEAD-** ile başlayan bir bağlantı olması gerekiyor. Ona bağlanın ve şifre olarak **12345678** girin.

Sonra hemen telefonunuzdan uygulamayı açarak en alt kısımda ki yeni ekleme butonuna tıklayın. En altta ki **Compatible Pairing Mode(AP)**'e tıklayın. Açılan ekranda benim anlattığım şeyleri göreceksiniz. Sonrasında ki **Sonraki** tuşuna tıklayın. Çıkan ekranda modeminizin SSIP ve şifre bilgisini girin ve ilerleyin. Dikkat edin, mazı modemlerde 2.4 Ghz ve 5 Ghz seçenekleri olabiliyor ve iki farklı SSIP oluyor. 2.4 Ghz olanı girmeniz gerekiyor. Sonrada ürün için bir isim girmeniz gerekiyor ve bu işlem sonucunda artık cihazı telefondan kontrol edebilirsiniz. Aynı network üzerinde olmadan ev ağına bağlı olmadanda kontrol edebilirsiniz. Sadece **SonOff**'un sürekli olarak internete bağlı olması yeterli.

Ayrıca kendi özel sunucunuzdan erişebilmeniz içinde bazı ayarlamalar yapabilirsiniz.
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

Böylelikle belirttiğiniz sunucuya tanımlamış oluyorsunuz.
Fakat tam bir gün boyunca local server kurup çalıştırmayı denedikten sonra kötü bir haber ile karşılaştım. Kötü haber şu ki SSL doğrulaması yapıyor ve local sunucu ssl'i doğrulanmadığından dolayı bağlanamıyor. Bununla ilgili bir çok kişi talepte bulunulmuş ve nisan ayında bu konuda düzenleme yapılacağı söylenmiş. O zamana kadar eWeLink uygulamasını kullanmaya zorunluyuz.
