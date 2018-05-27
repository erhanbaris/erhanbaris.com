---
layout: posts
title: IPhone Sniffing ve Uygulama Kandırma
lang: tr
tags:
  - IPhone
  - Nodejs
  - Sniffing
  - charlesproxy
date: 2018-05-27 19:09:05
---

Eşimin kullanmış olduğu bir sosyal medya aracını merak edip kullanmaya başladım. Tabi benim kullanma amacım tam olarak nasıl çalıştığını ve neler yapılabileceğini anlamak içindi. Fakat uygulama kısa bir süre sonra benden para istemeye başladı ve kullanılamaz hale geldi. Bu oldukça can sıkıcı oldu. Tabi daha tam olarak incelemem bitmediği için tam olarak can sıkıcı bir durum oldu. Sonrasında bu engeli nasıl aşabileceğime yoğunlaştım ve bunlarıda sizlerde paylaşmak istedim.
Öncelikle uygulama merkezi bir yer ile irtibata geçip oradan kendini kontrol etmesi gerekiyordu.

> - Halen beni kullanabilir mi?
> - Evet kullanabilir

yada

> - Halen beni kullanabilir mi?
> - Hayır, yeterince denedi, para vermesi lazım

mesajını eğer yakalarsam bir şekilde bunu değiş tokuş esnasında düzenlemeyebilirim diye düşündüm.

İlk hedefim Ios uygulamasının internette gönderdiği ve aldığı bütün mesajları incelemek olduğuna karar verdim.
Internetten [https://www.charlesproxy.com/](https://www.charlesproxy.com/ "https://www.charlesproxy.com/") uygulamasını indirdim ve IPhone cihazım üzerinde bazı düzenlemeler yapmam gerekti.
Kullandığım bilgisayar ve Iphone cihazımı aynı wifi ağında olduğundan emin olduktan sonra Iphone üzerinden
1. Ayarlar
2. Wifi
3. Kablonet(sizin bağlı olduğunu Wifi ağı)
4. En altta **Proxy'yi Ayarla**
5. **Elle** seçeneğini seçin ve en alt kısımda ki **Sunucu** kısmına bilgisayarınızın Ip adresini yazın. Benim için bu 192.168.0.14. Kapı(port) kısmınada **8888** bilgilerini girip sağ üst kısımda ki **Kaydet** tuşu ile işlemi bitirdim.

Kullandığınız proxy uygulaması farklı olabilir ve buna göre port bilgisi farklı olabilir.
Artık telefonunuz için ayarlamaları yaptığımıza göre test edebiliriz.
Charles Proxy uygulamamızı açıyoruz ve telefonumuzdan **Tags For Insta** isimli uygulamayı açıyoruz. Bu benim üzerinde çalıştığım uygulama, siz kontrol etmek istediğiniz uygulamayı açabilirsiniz.
Uygulama açılınca öncelikle olarak google, facebook gibi bir kaç tane siteye bağlandıktan sonra 9brainz.com isimli siteye bağlandı. Evet işte beklediğim bağlantıda buydu. İletişim bilgilerine baktığımda tam olarak aradığım bağlantının olduğu anlaşıldı.

IPhone üzerinden gönderilen bilgi.
{% codeblock lang:json %}
{
	"deviceId": "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
}
{% endcodeblock %}

9brainz sitesi üzerinden gelen cevap.
{% codeblock lang:json %}
{
	"success": true,
	"data": {
		"deviceId": "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX",
		"isRemoveAdsPurchase": false,
		"isFreeSearchOver": true,
		"isSubscriptionOn": false,
		"lastDateOfSubscription": "18-05-2018"
	}
}
{% endcodeblock %}

Sunucuya cihazımın bilgisini gönderiyorum ve o da bana ne kadar süre kullanabileceğimi ve neler yapabileceğim bilgisini dönüyor. Bu oldukça kolay ilerliyor.
Şimdi tek yapmam gereken şey 9brainz sunucusundan gelen mesajı istediğim gibi değiştirmek. Bu da kolay bir işlem, çünkü telefonumun bütün internet akışı şu anda bilgisayarım üzerinden gidiyor.

Öncelikle 9brainz.com domain sunucusunu aradan çıkartmam ve kendi web sunucuma yönlendirmem gerekiyor. Bunun için hosts dosyasını düzenlemem yeterli. Şu anda MacOsX kullanıyorum ve benim hosts dosyam **/etc/** dizini içerisinde. Gerekli yetkileri verip (**chmod +x /etc/hosts**) içerisinde 
**127.0.0.1 9brainz.com**
satırını ekliyorum.
Sırada telefonumdan gelen sorgulamayı karşılayacak olan kodu yazmakta. Ben burada hızlı bir çözüm olması için nodejs ve expressjs kullanmaya karar verdim.

{% codeblock lang:javascript %}
const express = require('express')
const app = express()

app.post('/InstagramLiveFatih/public/api/loginOrRegister', function(req, res) { 
    
    res.setHeader('Content-Type', 'application/json');
    res.send(JSON.stringify({
	"success": true,
	"data": {
		"deviceId": "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX",
		"isRemoveAdsPurchase": true,
		"isFreeSearchOver": true,
		"isSubscriptionOn": true,
		"lastDateOfSubscription": "18-05-2020"
	}
}));
});

app.listen(80, () => console.log(''))
{% endcodeblock %}

"deviceId": "**XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX**" bilgisini Iphone üzerinden gönderilen deviceId ile değiştirmeniz gerekiyor. Sonrasında uygulamayı telefonunuzdan silip tekrar yükleyin ve açın. İlk açıldığı anda sizin bilgisayarınız üzerinden sorgulama işlemi yapıp reklamsız ve sınırsız olarak uygulamayı kullanmanıza olanak sağlayacaktır.
Tabi bu işlemler her uygulama için geçerli değildir. Her sorunun kendine özgü bir çözüm yöntemi ve yolu bulunmaktadır. Ben burada sadece kendi yaşadığım sorunda uygulamış olduğum çözüm yöntemini göstermek istedim.
Bunlar tamamen öğrenim ve test amaçlıdır. Siz yinede **Tags For Insta** uygulamasının karşılığı olan ücreti ödeyerek kullanının, onlarda kazansın sizde kazanın.