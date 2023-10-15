---
title: Modern bebek uyku takibi
tags: 
 - Bebek
 - Arduino
 - Membantu
 - Home Assistant
 - ESPHome
lang: tr
---

## Giriş

Bir bebeğinizin olması hayatınızda başınıza gelen en güzel şeylerden birisidir. Hayatınızda bir çok güzellik ve yenilik ile birlikte gelir. Ama sürekli olarak uykusunu, yemesini ve tuvaletini takip etmeniz de gerekir. Her değişikliği bilmek hayatı önem taşır. Bebeğin ağlaması, uyuması, emmesi, tuvaletini ne renkte ve ne sıklıkta yaptığı her biri gelişiminin nasıl gittiği ile ilgili bize ip uçları veriyor. Bütün bu durumlar için ücretli ve ücretsiz olarak bir çok uygulama mevcut.
Bebeğimizi ne zaman uyuttuğumuzu takip etmek bizim için sorun olmaya başlayınca bunu nasıl otomatikleştiririz diye düşündük. 
Kullandığımız beşik aşağıda ki gibi ve yana sallanmak yerine yukarı aşağı yönünde sallanmakta.

![](./Bebek-uyku-takibi/membantu.jpg)

Üzerinde ki küçük motor beşiği salliyor. İşin gerçeği bu beşik bizi gerçektende çok rahatlattı, bebeğin kolaylıkla uyumasına yardımcı oluyor. Peki bu beşik ile uyku takibi nasıl yapılır? Önceden satın aldığım Arduino ve sensörler ile birşeyler yapabilir miyim diye düşündük ve denemeye karar verdik.

Daha önceden almış olduğum Arduino ve sensörler ile neler yapılabileceğini araştırmaya başladım. Fakat önceden hiç bir tecrübem olmadığı için neyin doğru yada yanlış olduğunu anlamak zor oldu.
Bir çok seçenek arasından doğru olanı bulmak zaman alıyor. İşte bunlarda araştırmalarım ve denemelerimin sonuçları.

### Titreşim sensörü ile hareket algılama
İlk aklıma gelen beşik eğer hareket ediyorsa bebekte uyuyor mantığından hareket ederek hareket sensörü ile takip etmekti. Bu doğrultuda elimde bulunan bütün sensörleri tek tek araştırdım ve sonunda ihtiyacım olan sensörü buldum.

![](./Bebek-uyku-takibi/SW420-Vibration-Sensor-Module.jpg)
Neredeyse bütün Arduino kitler ile birlikte satılan **sw-420 vibration sensor module** tam aradığım çözümdü benim için. İlk olarak elimde bulunan Arduino Nano ile neler yapabileceğimi görmek için internetten [Arduino Ide](https://www.arduino.cc/en/software) uygulamasını indirip kurdum. Internette yaptığım kısa bir arama sonucunda (ki hatta Arduino Ide içerisinde ki örneklerde de mevcut) basit bir örnek uygulama kodu buldum.

İlk denemelerimde cihaz istediğim gibi çalışıyor ama sürekli olarak **on**/**off** mesajı gönderdi. Durum değişikliği için düzenlemeler yaptım ama pek işe yaramadı. Internette araştırma yaparken **Home Assistant** ile tam entegre olab **ESPHome** ile bu tarz şeylerin çok daha hızlı ve kolay yapılabileceğini keşfettim.

Ama bir sorun ile daha karşılaştım. Bu cihaz benim ev otomasyonum ile nasıl haberleşecek???
Ev otomasyonuma WIFI üzerinden bilgi göndermesi gerekiyordu ve elimde hiç WIFI modülü yoktu. Kısa bir araştırma sonucunda **ESP328266** satın aldım.
Aşağıda bulanacağınız linkten sipariş verip denemelerime kaldığım yerden devam ettim.
* https://www.amazon.de/dp/B0754N794H?ref=ppx_yo2ov_dt_b_product_details&th=1

Hızlı bir şekilde uygulamayı **ESPHome** aracılığı geliştirdim ve takibe başladım. İlk bir kaç kullanımda gerçektende istediğim sonucu verdi ama sonrasında tutarsız sonuçlar göndermeye başladı. **on** yada **off** durumunda takılı kalıyor yada hatalı mesaj göndermeye devam ediyordu. Üzerinde ki kalibrasyon ayarı ile düzenleme yapmaya çalışsamda pek başarılı olduğum söylenemez.  Tam bir hayal kırıklığı olduğunu söyleyebilirim.
Aşağıda kullandığım örnek bulunmakta. İlgilenenler olursa istedikleri gibi kullanabilir.

{% codeblock vibration_test.toml lang:toml %}
esphome:
  name: vibration_test
  friendly_name: vibration_test

esp8266:
  board: esp01_1m

# Enable logging
logger:
web_server:
  port: 80
# Enable Home Assistant API
api:
  encryption:
    key: "r4Lic9LOwYNBrDj8w2E2rOlnkfwVf7x9qgDsEH8YODg="

ota:
  password: "d90203ec782f13da794ab9b729051c2a"

wifi:
  ssid: !secret wifi_ssid
  password: !secret wifi_password

  # Enable fallback hotspot (captive portal) in case wifi connection fails
  ap:
    ssid: "Test Fallback Hotspot"
    password: "oweH1F2KTtO9"

captive_portal:

time:
  - platform: sntp
    id: baby_bed_time

sensor:
  - platform: uptime
    name: "Uptime baby bed"
  - platform: wifi_signal
    name: "WiFi Signal at baby bed"
    update_interval: 60s

binary_sensor:
  - platform: gpio
    name: "BabyBed"
    id: "BabyBed"
    device_class: vibration
    filters:
      delayed_on_off: 10s
    pin: 
      number: 0
      mode: INPUT

{% endcodeblock %}

{% codeblock "Örnek Çıktı" %}
[21:15:13][D][binary_sensor:034]: 'BabyBed': Sending initial state ON
[21:15:32][D][binary_sensor:036]: 'BabyBed': Sending state OFF
{% endcodeblock %}

### Ultrasonic sensör ile mesafe ölçme

Elimde bulunan diğer sensörleri teker teker inceleyip işime yarayacak bir sensör çıkar mı diye araştırırken **Ultrasonic Sensor HC-SR04** ile denemeler yapmaya karar verdim.

![](./Bebek-uyku-takibi/Ultrasonic-Sensor-HC-SR04.webp)

Beşiğin aşağı-yukarı yönünde ki hareketleri algılamak için mesafe ölçümü yapıp, basit bir mantık ile bunu algılamak zor olmasa gerek değil mi?
İlk başlarda herşey basit ve kolay başladı fakat kısa süre sonra ölçümlerde hatalar görünmeye başladı.

Şekilde ki gibi saniyede beklenen mesafe 15cm civarında.

![](./Bebek-uyku-takibi/hareket.jpg)

İlk başlarda ciazı beşiğin altına yerleştirmiktik ama eşimin endişesi dolayısıyla çubuğun ucuna yere bakacak şekilde yerleştirdim. Böylelikle ölçümleri beşiğin dışından yapmaya başladı. Ama bu seferde yerleştirdiğim yerden hareket eden ölçüm cihazı beşiğin hareketsiz kaldığını bildirmeye başladı. Bunu çözmek için ise 10 dakikalık bir zaman aşımı ekleyip, eğer beşik 10 dakika içerisinde durup tekrar hareket ederse bunu sadece tek bir zaman dilimi olarak algılayacak şekilde düzenledim. 

İşte burada da **ESPHome** entegrasyon kodu:
{% codeblock ultrasonic_test.toml lang:toml %}

esphome:
  name: baby-bed-move-detector
  friendly_name: baby-bed-move-detector
  
esp8266:
  board: esp01_1m

# Enable logging
logger:
    level: INFO

web_server:
  port: 80
  
# Enable Home Assistant API
api:
  encryption:
    key: "+vWN6Zu+Q9T8Ld9yAhjsesNe0iJMsYT7ZCfWocdBVQM="

ota:
  password: "da2086ea9b66d498385002496346209f"

wifi:
  ssid: !secret wifi_ssid
  password: !secret wifi_password

  # Enable fallback hotspot (captive portal) in case wifi connection fails
  ap:
    ssid: "Baby-Bed-Move-Detector"
    password: "RVc2kXcrHnGg"

captive_portal:

text_sensor:
  - platform: template
    name: "Baby Sleeping"
    id: output_baby_in_cradle
    update_interval: never

  - platform: template
    name: "Sleep Start Time"
    id: sleep_start_time
    update_interval: never

  - platform: template
    name: "Duration"
    id: sleep_duration
    update_interval: never

binary_sensor:
  - platform: template
    name: "Baby Sleeping"
    id: moving
    device_class: motion

time:
  - platform: sntp
    id: sntp_time

sensor:
  - platform: duty_time
    id: sleep_time
    name: Sleep Time
    sensor: moving

  - platform: ultrasonic
    trigger_pin: 0
    echo_pin: 4
    name: distance
    update_interval: 100ms
    unit_of_measurement: cm
    #accuracy_decimals: 2
    filters:
      - multiply: 100
      #- filter_out: nan
      #- delta : 0.05
      - sliding_window_moving_average:
          window_size: 100
          send_every: 100
          send_first_at: 100
      
    on_raw_value:
      then:
        lambda: |-
          static auto start_time = id(sntp_time).now();
          static auto  last_start_time     = id(sntp_time).now();
          static bool  has_last_start_time = false;
          static int   start_time_timeout  = 10 * 60; //minutes

          static int   distance_window   = 0;
          static int   nan_counter       = 0;
          static float distance_max      = 0.0;
          static float distance_min      = 0.0;
          static float previous_distance = 0.0;

          static int idle_timeout = 3;
          static int idle_timer   = 0;

          static int sleeping_timeout = 3;
          static int sleeping_timer   = 0;

          // ESP_LOGI("INFO", "The value is %f", x);

          /* It is not possible to shake more than 40cm. Discart current value. */
          float is_value_valid = distance_max - distance_min < 0.4;
          if (!is_value_valid) {
            // ESP_LOGI("INFO", "The value has been discarded due to invalid read");
            // return;
          }

          ESP_LOGI("INFO", "The value is %f", x);
          
          if (distance_window++ > 100)
          {
            distance_window = 0;
            
            ESP_LOGI("INFO", "The value of sensor is: max: %f min: %f diff: %f", distance_max, distance_min, distance_max - distance_min);

            float is_moving     = distance_max - distance_min > 0.1;
            bool is_value_valid = nan_counter < 70;
            nan_counter         = 0;

            if (is_moving && is_value_valid) {

              // Icrease sleeping timer
              sleeping_timer++;

              // Did we wait enough to change status?
              if (sleeping_timer >= sleeping_timeout) {

                // Change status to idle
                id(output_baby_in_cradle).publish_state("Sleeping");
                id(moving).publish_state(true);

                auto now = id(sntp_time).now();

                // Is first time to initialize?
                if (!has_last_start_time) {
                  ESP_LOGI("INFO", "New session started");
                  has_last_start_time = true;
                  last_start_time     = now;
                  start_time          = now;

                } else {
                  // The system had a session but is it expired?
                  bool is_session_expired = now.timestamp - last_start_time.timestamp > start_time_timeout;
                  last_start_time         = now;

                  if (is_session_expired) {
                    ESP_LOGI("INFO", "Session expxired, new session started");
                    start_time = now;
                  } else {
                    ESP_LOGI("INFO", "Session restored or continued");
                  }
                }

                // Current time
                id(sleep_start_time).publish_state(start_time.strftime("%H:%M"));

                time_t duration = (time_t) now.timestamp - start_time.timestamp;
                char duration_as_str[17];
  
                int hours_elapsed = duration / 3600;
                int minutes_elapsed = (duration % 3600) / 60;
                int seconds_elapsed = duration % 60;

                sprintf(duration_as_str, "%02i:%02i:%02i", hours_elapsed, minutes_elapsed, seconds_elapsed);

                // Sleep Duration
                ESP_LOGI("INFO", "Sleep duration: %s", duration_as_str);

                id(sleep_duration).publish_state(duration_as_str);
                
                // Reset all states
                sleeping_timer = 0;
                idle_timer = 0;
                previous_distance = 0.0;
              }

            } else {
              // Icrease idle timer
              idle_timer++;

              // Did we wait enough to change status?
              if (idle_timer >= idle_timeout) {

                // Change status to idle
                id(output_baby_in_cradle).publish_state("Idle");
                id(moving).publish_state(false);

                id(sleep_start_time).publish_state("N/A");
                
                // Reset all states
                sleeping_timer = 0;
                idle_timer = 0;
                previous_distance = 0.0;
              }
            }
          }
          
          if (isnan(x)) {
            x = previous_distance;
          }

          // If the distance more than 50 cm, set to 50 cm
          //if (x > 0.5) {
          //  x = 0.5;
          //}

          previous_distance = x;

          if (distance_window == 1)
          {
            distance_max = x;
            distance_min = x;
          }
          else
          {
            if (x > distance_max)
            {
              distance_max = x;
            }
            if (x < distance_min)
            {
              distance_min = x;
            }
          }

  - platform: uptime
    name: "Uptime"
  
  - platform: wifi_signal
    name: "WiFi Signal"
    update_interval: 60s
{% endcodeblock %}

Fark edeceğiniz üzerine içerisinde **C++** koduda var. Bu şekilde ince düzenlemeler yaparak istediğime yakın sonuçlar almaya başladım.

İşte burada da **Home Assistant** panelinde ki görüntüsü. Oldukça heyecan verici bir andı. 

![](./home-assistant-sc.png)

Ne zaman ve ne kadar süredir uyuduğunu, cihazın ne zamandan beri aktif olduğunu görülebilir.

Ama burada da sorunlar ile karşılaştım. Sistem aralıklarla **nan** değeri döndürmeye başladı ve bazen sadece **nan** döndürdü.

{% codeblock "Örnek Çıktı" %}
[21:47:15][I][INFO:111]: The value is nan
[21:47:15][I][INFO:111]: The value is nan
[21:47:15][I][INFO:111]: The value is nan
[21:47:15][I][INFO:111]: The value is nan
[21:47:15][I][INFO:111]: The value is 0.670051
[21:47:15][I][INFO:111]: The value is nan
[21:47:15][I][INFO:111]: The value is nan
[21:47:15][I][INFO:111]: The value is 0.834691
[21:47:15][I][INFO:111]: The value is 0.880138
[21:47:15][I][INFO:111]: The value is 0.858186
[21:47:16][I][INFO:111]: The value is 0.792845
[21:47:16][I][INFO:111]: The value is nan
[21:47:16][I][INFO:111]: The value is nan
[21:47:16][I][INFO:111]: The value is 0.688573
[21:47:16][I][INFO:111]: The value is nan
[21:47:16][I][INFO:111]: The value is nan
[21:47:16][I][INFO:111]: The value is 0.837092
[21:47:16][I][INFO:111]: The value is nan
[21:47:16][I][INFO:111]: The value is nan
[21:47:16][I][INFO:111]: The value is 0.767634
[21:47:17][I][INFO:111]: The value is 0.707094
[21:47:17][I][INFO:111]: The value is 0.687029
[21:47:17][I][INFO:111]: The value is nan
[21:47:17][I][INFO:111]: The value is nan
[21:47:17][I][INFO:111]: The value is 0.802791
[21:47:17][I][INFO:111]: The value is 0.854927
[21:47:17][I][INFO:111]: The value is 0.870534
[21:47:17][I][INFO:111]: The value is 0.829374
[21:47:17][I][INFO:111]: The value is nan
[21:47:17][I][INFO:111]: The value is nan
{% endcodeblock %}

Bazı düzenlemeler yapsamda tam istediğim gibi çalışmıyor.

Not: Burada titreşim sensörü ve ultrasonik seksör bağlantı şemalarını paylaşmıyorum, internette aratarak kolayca bulabilirsiniz.

**ESPHome** yasesinde sonsuruz bir şekilde **Home Assistant** ile entegrasyon sağladım ve web arayüzü ile anlık olarak debug bilgilerine erişim sağlayabildim.

Tabi bu kadar ilede kalmadı ve başka bir sorun ile karşılaştık. Bu seferde bebek beşiğin içerisinde olduğu halde uyumuyordu :/


### Kamera ile göz takip etme
Bir sonra ki adım olarak dedik ki neden kamerayı beşiğin içerisine koyup bebeiğin uykusunu takip etmiyoruz ki? Hem böylelikle gerçek bir veriye ulaşmış oluruz. Saklanmak yada sarsılmalar güzel ama gerçektende bebeğin uyuyup uyumadığı bilgisini bize vermiyor. Bunun yerine sadece dışarıdan en iyi tahmini yapmamızı sağlıyor.

Hemen internete girip **Arduino** ile uyumlu kameraları araştırdım ve **ESP32-CAM** karşıma çıktı. Şiir gibi bir cihaz, hem WIFI var, hem kamera var hemde **ESP32** tabanlı yani **ESP328266** ile bağlantı yapmama gerek yok. Hemen satın aldım. Şurayada linkini bırakayım:
* https://www.amazon.de/dp/B08X3GRK22?psc=1&ref=ppx_yo2ov_dt_b_product_details

Bir kaç gün beklememin ardından ürün elime ulaştı ve hemen ilk denemeleri yapmaya başladım.

Tam bir hayal kırıklığı. Hem görüntü kalitesi kötü, hem çok yavaş hemde karanlık. Beşiğin içerisinde koyduğumda bebeği görmek şöyle dursun herhangibir net görüntü bile alamadım. Onu iade etmek zorunda kaldım.






```python
import hashlib
import os
import base64
from datetime import datetime

username = "admin"
password = "pass"
# created = datetime.now().strftime("%Y-%m-%dT%H:%M:%S.000Z")
created = datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%S.000Z")

raw_nonce = os.urandom(20)
nonce = base64.b64encode(raw_nonce)

sha1 = hashlib.sha1()
sha1.update(raw_nonce + created.encode('utf8') + password.encode('utf8'))
raw_digest = sha1.digest()
digest = base64.b64encode(raw_digest)

template = """<s:Envelope xmlns:s="http://www.w3.org/2003/05/soap-envelope">
    <s:Header>
        <Security s:mustUnderstand="1" xmlns="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">
            <UsernameToken>
                <Username>{username}</Username>
                <Password Type="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordDigest">{digest}</Password>
                <Nonce EncodingType="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-soap-message-security-1.0#Base64Binary">{nonce}</Nonce>
                <Created xmlns="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd">{created}</Created>
            </UsernameToken>
        </Security>
    </s:Header>
    <s:Body xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
        <wsdl:GetProfiles/>
    </s:Body>
</s:Envelope>"""

req_body = template.format(username=username, nonce=nonce.decode('utf8'), created=created, digest=digest.decode('utf8'))
print(req_body)


"""
<wsdl:GetStreamUri>
    <wsdl:ProfileToken>PROFILE_001</wsdl:ProfileToken>
</wsdl:GetStreamUri>
"""
```

```bash
python3 onvif.py > request.xml
curl --silent -X POST --header 'Content-Type: text/xml; charset=utf-8' -d @request.xml 'http://192.168.1.222:9000/onvif/device_service' | xmllint --format -
```