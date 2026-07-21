#let c0 = rgb("#D72964")
#let c1 = rgb("#8C195F")
#let c2 = rgb("#191919")
#let c3 = rgb("#FFFFFF")
#show heading: set text(font: "Ubuntu Sans", fill: c2)

#let arc = (start, stop, r, ..args) => {
  let (fst, ..pts) = range(int((stop - start).deg())).map(x => {
    let a = start.rad() + (x * 1deg).rad()
    (
      r * calc.cos(a),
      r * calc.sin(a),
    )
  })
  curve(
    ..args,
    curve.move(fst),
    ..pts.map(curve.line),
  )
}

#let logo(size) = {
  let s = (thickness: size * .101, cap: "round")
  let p = size / 2
  box(width: size, height: size, {
    place(dx: p, dy: p, arc(0deg, 270deg, p, stroke: (..s, paint: c2)))
    place(dx: p, dy: p, arc(45deg, 315deg, p * .8, stroke: (..s, paint: c1)))
    place(dx: p, dy: p, arc(90deg, 360deg, p * .6, stroke: (..s, paint: c0)))
  })
}

#let fit-text-w(body) = layout(size => {
  let font_size = text.size
  let (width,) = measure(
    text(size: font_size)[#body],
  )
  let max_width = size.width
  while width < max_width {
    font_size += 0.1pt
    width = measure(
      text(size: font_size)[#body],
    ).width
  }
  text(size: font_size - 0.1pt)[#body]
})

#set document(
  author: "Open\OST",
  title: "Quickstart Guide",
  date: datetime.today(),
)
#set page("a4", margin: 1.25cm)
#set text(fill: c2, font: "JetBrainsMono NF", lang: "de")
#show link: it => box(text(fill: c0, size: .9em, it))

#place(dx: 92%, dy: 23%, logo(250pt))
#place(dx: -90pt, dy: 70%, logo(300pt))
#place(
  dx: -.3cm,
  dy: 80%,
  box(width: 5cm, height: 5cm, align(center + horizon, [
    #text(size: 2em)[Jetzt Mitglied werden!] \
    #text(size: .9em)[Natürlich unverbindlich und kostenlos] \
    #link("https://open-ost.ch")[open-ost.ch]
  ])),
)

#grid(
  columns: (2.5fr, 3fr),
  column-gutter: 1em,
  row-gutter: 2em,
  align(horizon, grid(
    columns: 2,
    gutter: 1em,
    logo(100pt),
    [
      #set text(font: "Ubuntu Sans")
      #fit-text-w[OPEN]
      #fit-text-w[*OST*]
    ],
  )),
  align(horizon)[
    #set text(font: "Ubuntu Sans")
    #fit-text-w[Quickstart Guide] \
    #fit-text-w[für Linux und macOS an der OST]
  ],

  [
    == WLAN

    #grid(
      gutter: 1em,
      columns: (1fr, 1fr),
      [SSID], [eduroam],
      [Security], [WPA2 Enterprise],
      [Authentisierung], [PEAP],
      [CA-Zertifikat], [Keines],
      [Innere-Auth.], [MSCHAPv2],
      [], [],
      [Benutzername], [max.muster\@ost.ch],
      [Passwort], range(8).map(_ => math.circle.filled).join(),
    )

    Weitere Infos zum Aufsetzen des WLANs auf Linux/MacOS
    https://wiki.ost.ch/x/toDS

    == VPN

    Manche Dienste der OST sind nur in deren internen Netzwerken zugänglich. Ist
    man nicht an einem OST-Campus, so kann man per VPN zu diesem Netzwerk
    verbinden. \
    Für VPN-Verbindungen muss auf dem OST-Account 2-Faktor-Auth aktiviert sein.
    Siehe https://wiki.ost.ch/display/IOW/VPN+OST
  ],
  [
    == Studentenportal

    Der Zentrale Ort für Wissensverwaltung: von Studierenden, für Studierende.
    Für kommende Events, wertvolle Tipps, Zusammenfassungen und alte Prüfungen
    oder einfach nur zur Aufheiterung während\ einer Vorlesung, schau vorbei auf
    https://studentenportal.ch

    == OST-Account

    === Passwort

    Das Passwort des OST-Accounts ist\ änderbar auf
    https://wiki.ost.ch/change-password

    === Profilbild

    Dein Profilbild und weitere\ Profilangaben änderbar unter
    https://ostch-my.sharepoint.com/person.aspx

    == E-Mail

    Der Exchange-Server der OST bietet nur das proprietäre EWS-Protokoll an, das
    ausser von MS Outlook nur von wenigen Mail-Clients (z.B. Evolution)
    unterstützt wird. Die von quasi allen Mail-Clients unterstützten Protokolle
    SMTP und IMAP sind auf der Exchange-Instanz der OST "aus Sicherheitsgründen"
    abgeschaltet.

    #grid(
      gutter: 1em,
      columns: (1fr, 3fr),
      [Linux], [Evolution mit EWS-Plugin],
      [macOS], [Microsoft Outlook],
      [Webmail], [https://outlook.com],
    )

    Falls du deinen E-Mail-Client frei wählen können willst, tritt dem open\OST
    bei, der sich für Interoperabilität, Plattform-Unabhängigkeit und den
    Einsatz offener, freier Protokolle an der OST einsetzt.

    == Und Mehr...

    Linux-Anleitungen der OST-IT findest du unter
    https://wiki.ost.ch/display/public/IOW/Linux
  ],
)
