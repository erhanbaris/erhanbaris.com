---
title: Bebeğimin uykusunu nasıl takip ediyorum
tags: 
 - Bebek
 - Arduino
 - Membantu
 - Home Assistant
 - ESPHome
 - MediaPipe
lang: tr
---

## Giriş

Bir bebeğinizin olması hayatınızda başınıza gelen en güzel şeylerden birisidir. Hayatınızda bir çok güzellik ve yenilik ile birlikte gelir. Her zaman yapmış olduğunuz şeyleri bir kenarıya bırakıp yeni alışkanlıklar edinmelisiniz. Hayatınızı bebeğin uyku, yeme ve eğitim düzenine göre yeniden şekillendirmelisiniz. Uykusunu, yemeğini ve tuvaletini takip etmek bu bakımdan çok önemlidir. Bebeğin ağlaması, uyuması, emmesi, tuvaletini ne renkte ve ne sıklıkta yaptığı her biri gelişiminin nasıl gittiği ile ilgili bize ip uçları veriyor. Bir ebeveyn olarak bebeğin bütün gelişiminden birincil olarak sorunlusunuzdur. Bebek gelişim takibi için ücretli ve ücretsiz olarak bir çok uygulama mevcut. Fakat bütün bu uygulamalara bilgileri kendiniz girmeniz gerekiyor.
Bebeğimizi ne zaman uyuttuğumuzu takip etmek bizim için sorun olmaya başlayınca bunu nasıl otomatikleştiririz diye düşündük. Bunun için ücretli çözümler mevcut fakat oldukça pahalı. Örnek olarak çorap gibi ayağa giydirilen bir sensör ile bu bilgileri alabilirsiniz. Fakat buna ücret ödemek yerine kendimiz elimizde ki ekipman ile birşeyler yapabilirmiyiz diye araştırmaya başladık.
Öncelikli olarak kullanabileceğimiz ekipmanı belirlemek ile başladık. Kullandığımız beşik aşağıda ki gibi ve yana sallanmak yerine yukarı aşağı yönünde sallanmakta.

<figure>
    <img src="membantu.jpg">  
    <figcaption style="text-align: center">Membantu Beşik</figcaption>
</figure>


Üzerinde ki küçük motor beşiği salliyor. İşin gerçeği bu beşik bizi gerçektende çok rahatlattı, bebeğin kolaylıkla uyumasına yardımcı oluyor. Peki bu beşik ile uyku takibi nasıl yapılır? Önceden satın aldığım Arduino ve sensörler ile birşeyler yapabilir miyim diye düşündük ve denemeye karar verdik.

Daha önceden almış olduğum Arduino ve sensörler ile neler yapılabileceğini araştırmaya başladım. Fakat önceden hiç bir tecrübem olmadığı için neyin doğru yada yanlış olduğunu anlamak zor oldu.
Bir çok seçenek arasından doğru olanı bulmak zaman alıyor. İşte bunlarda araştırmalarım ve denemelerimin sonuçları.

<hr />

### Titreşim sensörü ile hareket algılama
İlk aklıma gelen beşik eğer hareket ediyorsa bebekte uyuyor mantığından hareket ederek hareket sensörü ile takip etmekti. Bu doğrultuda elimde bulunan bütün sensörleri tek tek araştırdım ve sonunda ihtiyacım olan sensörü buldum.


<figure>
    <img src="SW420-Vibration-Sensor-Module.jpg">  
    <figcaption style="text-align: center">sw-420 vibration sensor module</figcaption>
</figure>


Neredeyse bütün Arduino kitler ile birlikte satılan **sw-420 vibration sensor module** tam aradığım çözümdü benim için. İlk olarak elimde bulunan Arduino Nano ile neler yapabileceğimi görmek için internetten **Arduino Ide**<sup>[link 1](#link-1)</sup> uygulamasını indirip kurdum. Internette yaptığım kısa bir arama sonucunda (ki hatta Arduino Ide içerisinde ki örneklerde de mevcut) basit bir örnek uygulama kodu buldum.

İlk denemelerimde cihaz istediğim gibi çalışıyor ama sürekli olarak **on**/**off** mesajı gönderdi. Durum değişikliği için düzenlemeler yaptım ama pek işe yaramadı. Internette araştırma yaparken **Home Assistant** ile tam entegre olab **ESPHome** ile bu tarz şeylerin çok daha hızlı ve kolay yapılabileceğini keşfettim.

Ama bir sorun ile daha karşılaştım. Bu cihaz benim ev otomasyonum ile nasıl haberleşecek???
Ev otomasyonuma WIFI üzerinden bilgi göndermesi gerekiyordu ve elimde hiç WIFI modülü yoktu. Kısa bir araştırma sonucunda **ESP328266** satın aldım<sup>[link 2](#link-2)</sup>.

Hızlı bir şekilde uygulamayı **ESPHome** aracılığı geliştirdim ve takibe başladım. İlk bir kaç kullanımda gerçektende istediğim sonucu verdi ama sonrasında tutarsız sonuçlar göndermeye başladı. **on** yada **off** durumunda takılı kalıyor yada hatalı mesaj göndermeye devam ediyordu. Üzerinde ki kalibrasyon ayarı ile düzenleme yapmaya çalışsamda pek başarılı olduğum söylenemez.  Tam bir hayal kırıklığı olduğunu söyleyebilirim.

<span class="info">

İlgilenen olursa [{% fa_inline github fab %}vibration.yaml](https://github.com/erhanbaris/baby-sleep-track/blob/main/approach-1/vibration.yaml) dosyasını inceleyebilir.

</span>

<br>

**Örnek çıktı:**
{% gist erhanbaris/bc6d9683a3e2d278851667e32759d585 vibration_test_output %}

{% alertbox success %}
**Artıları**: 
1. Kullanımı kolay
2. Bağlantı şeması sabit
3. Kodlaması yalın
{% endalertbox %}``

{% alertbox warning %}
**Eksileri**:
1. Sonuçlar güvenilmez
2. Ürün kalitesi düşük
3. Kalibrasyon ayarı olsa da hassasiyeti yeterli değil
4. Gerçek uyku durumunu vermiyor
{% endalertbox %}``

<hr />

### Ultrasonic sensör ile mesafe ölçme

Elimde bulunan diğer sensörleri teker teker inceleyip işime yarayacak bir sensör çıkar mı diye araştırırken **Ultrasonic Sensor HC-SR04** ile denemeler yapmaya karar verdim.


<figure>
    <img src="Ultrasonic-Sensor-HC-SR04.jpg">  
    <figcaption style="text-align: center">Ultrasonic Sensor HC-SR04</figcaption>
</figure>


Beşiğin aşağı-yukarı yönünde ki hareketleri algılamak için mesafe ölçümü yapıp, basit bir mantık ile bunu algılamak zor olmasa gerek değil mi?
İlk başlarda herşey basit ve kolay başladı fakat kısa süre sonra ölçümlerde hatalar görünmeye başladı.

Şekilde ki gibi saniyede beklenen mesafe 15cm civarında.


<figure>
    <img src="hareket.jpg">  
    <figcaption style="text-align: center">Beşik Hareketi</figcaption>
</figure>


İlk başlarda ciazı beşiğin altına yerleştirmiktik ama eşimin endişesi dolayısıyla çubuğun ucuna yere bakacak şekilde yerleştirdim. Böylelikle ölçümleri beşiğin dışından yapmaya başladı. Ama bu seferde yerleştirdiğim yerden hareket eden ölçüm cihazı beşiğin hareketsiz kaldığını bildirmeye başladı. Bunu çözmek için ise 10 dakikalık bir zaman aşımı ekleyip, eğer beşik 10 dakika içerisinde durup tekrar hareket ederse bunu sadece tek bir zaman dilimi olarak algılayacak şekilde düzenledim. 

İşte burada da **ESPHome** entegrasyon kodu:

<span class="info">

İlgilenen olursa [{% fa_inline github fab %}ultrasonic.yaml](https://github.com/erhanbaris/baby-sleep-track/blob/main/approach-2/ultrasonic.yaml) dosyasını inceleyebilir.

</span>

<br>

**ESPHome** içerisinde **C++** kullanarak daha esnek ve kullanışlı entegrasyonlar yapılabiliyor.  Sitesinde bu konuda bir çok bilgi ve örnek mevcut.

**Home Assistant** ekranında ki görüntüsü aşağıda. 


<figure>
    <img src="home-assistant-sc.jpg">  
    <figcaption style="text-align: center">Home Assistant Görüntüsü</figcaption>
</figure>


Ne zaman ve ne kadar süredir uyuduğunu, cihazın ne zamandan beri aktif olduğunu görülebilir.

Ama burada da sorunlar ile karşılaştım. Sistem aralıklarla **nan** değeri döndürmeye başladı ve bazen sadece **nan** döndürdü.

{% gist erhanbaris/79cd811611dcb55a88e050c370fd0512 ultrasonic_test_output %}

Bazı düzenlemeler yapsam da tam istediğim sonucu alamadım.

**ESPHome** yasesinde sonsuruz bir şekilde **Home Assistant** ile entegrasyon sağladım ve web arayüzü ile anlık olarak debug bilgilerine erişim sağlayabildim.

Tabi bu kadar ilede kalmadı ve başka bir sorun ile karşılaştık. Bu seferde bebek beşiğin içerisinde olduğu halde uyumuyordu :/

{% alertbox success %}
**Artıları**: 
1. Kullanımı kolay
2. Bağlantı şeması sabit
3. Daha gerçekçi sonuçlar veriyor
{% endalertbox %}``

{% alertbox warning %}
**Eksileri**:
1. Kodu karmaşık
2. Sıklıkla geçersiz sonuçlar döndürüyor
3. Gerçek uyku durumunu vermiyor
{% endalertbox %}``

<hr />

### Kamera ile göz takip etme
Peki beşiğin içerisine kamera koyup bebeğin uykusunu takip edebilir miyiz? Gözlerinin açık yada kapalı olduğunu takip etmek çok daha doğru sonuçlar verir. Diğer iki yaklaşım dışarıdan takip etmemize yarıyor ve genel sonuçlar veriyor ama kamera yaklaşımı çok daha etkili gibi görünüyor.

Elimde ki **ESP328266** ile uyumlu kamera ile araştıtken **ESP32-CAM** ile karşılaştım. Üzerinde entegre kamerası ve wifi modülü ile çok daha kullanışlı. Hem WIFI var, hem kamera var hemde **ESP32** tabanlı yani **ESP328266** ile bağlantı yapmama gerek yok<sup>[link 3](#link-3)</sup>.

Bir kaç gün beklememin ardından ürün elime ulaştı ve hemen ilk denemeleri yapmaya başladım.

Tam bir hayal kırıklığı. Hem görüntü kalitesi kötü, hem çok yavaş hemde karanlık. Beşiğin içerisinde koyduğumda bebeği görmek şöyle dursun herhangibir net görüntü bile alamadım. Onu iade etmek zorunda kaldım.

Fakat diğer bir seçenek ve aslında en mantıklısı ise bebek kamerası. Günlük olarak kullandığım **ieGeek Baby 1T**<sup>[link 4](#link-4)</sup> bebek kamerasında istediğim özellikler mevcut.
- **Gece görüşü** ile karanlık ortamda da kullanılabilir
- **Geniş açılı kamera** ile bebek beşiğinin içine yerleştirilebilir 
- **Net görüntü** sayesinde göz ve yüz detayları alınabiliyor

Tek sıkıntı ağ üzerinden kameraya erişim sağlama. Cihazın üzerinde **Onvif** desteği bulunuyor ama **Python** bunun yerine **rtsp** ile bağlanmak istiyorum. Bunun nedenide **OpenCv** ile erişim sağlamak için.

Kamerayı sabitlemek için internetten kamera tutucu satın aldım<sup>[link 5](#link-5)</sup>.

**rtsp** adresini almak biraz zahmetli oldu, internette otomatik olarak bu bilgiyi veren çözümler genellikle ücretli. Görüntü kalitesine göre iki farklı **rtsp** adresi mevcut.
- rtsp://USERNAME:PASSWORD@IP_ADDRESS:8554/Streaming/Channels/101
- rtsp://USERNAME:PASSWORD@IP_ADDRESS:8554/Streaming/Channels/102

**OpenCV** ile götüntüleri okuyup, sonrasında da içerisinde yüz var mı diye kontrol ettirmem gerekiyordu. İhtiyacıma göre bulabildiğim en iyi çözüm **Google MediaPipe**<sup>[link 6](#link-6)</sup> oldu.

Face mesh ile kolaylıkla yüz hatlarını algılanabiliyor.

<span class="info">

İlgilenen olursa [{% fa_inline github fab %} ikinci yöntem klasörü](https://github.com/erhanbaris/baby-sleep-track/blob/main/approach-3)'nü inceleyebilir.

</span>


<figure>
    <img src="face-mesh.png">  
    <figcaption style="text-align: center">Face Mesh ile Taranmış Yüz</figcaption>
</figure>



Bu sayede gözlerin açık yada kapalı olduğunu tespit etmek oldukça kolay oldu. Internette gözlerin durumunu kontrol etmek için bir çok örnek kod mevcut. Bunlardan birisini referans alarak bazı düzenlemeler yaptım.

Karşılaştığım en büyük sorun kameranın ters durduğu zaman hiç bir şekilde yüz tanımaması oldu. Bunu da görüntüyü 90 derece çevirip kontrol etmekte buldum. Eğer 90 derece çevrildiği zaman yüz tanımlanıyor ise bir sonraki tarama işleminde ilk olarak görüntü çevriliyor.

Gelen bilgiler doğrultusunda **Home Assistant** uygulamasına durum bilgisi gönderdim ve istediğime yakın olarak çalışmaya başladı. Tek sorun bu uygulama laptop üzerinde çalışıyor olmasıydı. Ama laptopum sürekli olarak açık olamayacağı için bunu bir şekilde **Home Assistant** üzerinde çalıştırmam gerekiyordu.

Bu tarz bir uygulama ancak **Home Assistant AddOn** olarak çalıştırılabilir. **Home Assistant** içerisinde uygulamalar **Docker** üzerinde çalıştırılıyor. Bu da benim küçük uygulamamı **Docker** üzerinden çalışır hale getirmem anlamına geliyor.

Şu anda bebeğimin uykusunu daha doğru bir şekilde takip ediyorum ama tek bir sorun kaldı. O da bebeğim yüzünü kameranın görmediği bir yere çevirince ne yazık ki yüz algılanamıyor. Bunun içinde iki adet kamera sipariş ettim. Köşelere yerleştirio iki farklı kaynaktan görüntüyü analiz etmek istiyorum. Henüz kameralar gelmediği için bunu deneyemedim.


<figure>
    <img src="home-assistant-sc2.jpg">  
    <figcaption style="text-align: center">Home Assistant Görüntüsü</figcaption>
</figure>


{% alertbox success %}
**Artıları**: 
1. Gerçek zamanlı ve tutarlı bilgi veriyor
2. Vücut pozisyonuna bakarak farklı veriler toplanabilir
{% endalertbox %}``

{% alertbox warning %}
**Eksileri**:
1. Kodu oldukça karmaşık
2. Bir sunucu da sürekli olarak çalışması gerekiyor
3. Sistem gereksinimleri yüksek
4. Uyumaya çalışan bebeğin dikkatini dağıtıyor
5. Pahalı ekipman gerekiyor
{% endalertbox %}``

## Sonsöz

Bebek uykusunu takip etmek için başladığım bu araştırma sonucunda bir çok yeni bilgi edindim. **Home Assistant** ile ne şekilde iletişim kurulabilir, **ESPHome** sayesinde kolaylıkla nasıl **Arduino** cihazları programlayabilir, **MediaPipe** ile yüz ve hareketler nasıl takip edilebilir gibi konuları öğrendim. Ayrıca farklı yaklaşımları test edip artılarını ve eksilerini görmek ilginç bir deneyim oldu.

Üç farklı yaklaşımın kendi içerisinde yüz tanımanın benim için en iyi seçenek olduğuna karar verdim. Bir çok eksisine rağmen şu anda kamera ile takibi kullanıyorum. **Home Assistant** üzerinde çalıştırmak yerine başka bir sunucu üzerinde çalıştırılırsa daha hızlı olacağını düşünüyorum.

<br>

<span class="info">

Projenin tam kaynak koduna [{% fa_inline github fab %}buradan](https://github.com/erhanbaris/baby-sleep-track/blob/main/approach-3) ulaşabilirsiniz.

</span>

<hr />

## Bonus Bölüm

**Scriptable** uygulaması ile bebeğin uyku durumunu ana ekrandan takip etmek için ufak bir **script** geliştirdim.

<figure>
    <img src="ios-sc.jpg">  
    <figcaption style="text-align: center">IOS Ekran Görüntüsü</figcaption>
</figure>

<span class="info">

İlgilenen olursa [{% fa_inline github fab %}BabySleepTracker.js](https://github.com/erhanbaris/baby-sleep-track/blob/main/bonus/BabySleepTracker.js) dosyasını inceleyebilir.

</span>

<br>

<hr />

_Not_: Titreşim ve ultrasonik seksör bağlantı şemalarını paylaşmıyorum, internette kolaylıkla bulabilirsiniz.

<hr />

#### Linkler

<a name="link-1" /><sup>1</sup> https://www.arduino.cc/en/software
<a name="link-2" /><sup>2</sup> https://www.amazon.de/dp/B0754N794H?ref=ppx_yo2ov_dt_b_product_details&th=1
<a name="link-3" /><sup>3</sup> https://www.amazon.de/dp/B08X3GRK22?psc=1&ref=ppx_yo2ov_dt_b_product_details
<a name="link-4" /><sup>4</sup> https://www.amazon.de/dp/B0CDGHV276?psc=1&ref=ppx_yo2ov_dt_b_product_details
<a name="link-5" /><sup>5</sup> https://www.amazon.de/dp/B0B8ZT5HDW?psc=1&ref=ppx_yo2ov_dt_b_product_details
<a name="link-6" /><sup>6</sup> https://developers.google.com/mediapipe
