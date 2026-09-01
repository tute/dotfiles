# Wifi y audio en iMac19,1 con Omarchy

Hecho el 2026-09-01 sobre kernel 7.1.9-arch1-2. Wifi y parlantes internos
andando.

## El problema

Wifi: `brcmfmac` detectaba el chip pero no arrancaba.

```
brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4364b2-pcie for chip BCM4364/3
brcmfmac 0000:03:00.0: Direct firmware load for brcm/brcmfmac4364b2-pcie.bin failed with error -2
```

`linux-firmware-broadcom` no trae nada de 4364. Apple no libera ese blob.

Audio: la placa estaba bien. Card 0 con codec Cirrus CS8409 (subsystem
0x106b1000), sink de PipeWire activo, sin mute, PCM al 95%, puerto
`analog-output-speaker`. Igual silencio. El driver in-tree
`snd-hda-codec-cs8409` solo tiene fixups para MacBooks (bullseye, warlock,
cyborg, dolphin). En iMac cae al parser generico: expone los pines 0x24/0x25
pero nunca inicializa el amplificador externo.

## Wifi

Para iMac19,1 la familia Apple es `midway`, revision B2 (dmesg dice `BCM4364/3`,
que es B2).

```
sudo pacman -U apple-bcm-firmware-14.0-1-any.pkg.tar.zst
cd /usr/lib/firmware/brcm
sudo ln -sf 'brcmfmac4364b2-pcie.apple,midway.bin'        brcmfmac4364b2-pcie.bin
sudo ln -sf 'brcmfmac4364b2-pcie.apple,midway.clm_blob'   brcmfmac4364b2-pcie.clm_blob
sudo ln -sf 'brcmfmac4364b2-pcie.apple,midway.txcap_blob' brcmfmac4364b2-pcie.txcap_blob
sudo ln -sf 'brcmfmac4364b2-pcie.apple,midway-HRPN-u.txt' brcmfmac4364b2-pcie.txt
sudo modprobe -r brcmfmac && sudo modprobe brcmfmac
```

El paquete sale de
`https://github.com/NoaHimesaka1873/apple-bcm-firmware/releases/download/v14.0/apple-bcm-firmware-14.0-1-any.pkg.tar.zst`.

Los symlinks son el fallback que usa `brcmfmac` cuando no resuelve board type
por DMI. `-HRPN-u` es la variante USI, la del iMac 2019; si la radio se portara
mal, la alternativa es `-HRPN-m` (Murata).

Resultado:

```
brcmfmac: brcmf_c_process_txcap_blob: TxCap blob found, loading
brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4364/3 wl0: Jul 10 2023 12:30:19 version 9.30.503.0.32.5.92
brcmfmac 0000:03:00.0 wlp3s0: renamed from wlan0
```

No hizo falta el workaround de wpa_supplicant 2.11
(`brcmfmac.feature_disable=0x82000` en `/etc/default/limine` + `limine-update`).
Queda anotado por si aparece.

## Audio

Driver out-of-tree de davidjo, que agrega el init del amplificador Apple que le
falta al in-tree. Tiene soporte de iMac (los pines DMIC van al reves que en
MacBook).

```
sudo pacman -S --needed linux-headers dkms alsa-utils
yay -S snd-hda-macbookpro-dkms-git
```

Queda cargando desde
`/lib/modules/$(uname -r)/updates/dkms/snd-hda-codec-cs8409.ko.zst`.

## Bluetooth: pendiente

El controlador enumera y esta powered, pero corre en modo MFG sin patch: pide
`brcm/BCM.hcd` y no lo encuentra. Ese `.hcd` no viene en el paquete de Apple,
que solo trae bluetooth para chips PCIe 4377/4378. El de este iMac es UART
(`hci_uart` + `btbcm`). Habria que sacarlo de los drivers de Boot Camp o de
macOS. Sin probar todavia si igual sirve para parear un parlante.

## Cosas a tener en cuenta

- El DKMS del audio se recompila en cada update de kernel. Si algun dia falla el
  build, te quedas sin sonido hasta arreglarlo.
- Los 4 symlinks de firmware no son propiedad de ningun paquete. Sobreviven a
  `pacman -Syu`, pero si algun dia reinstalas `apple-bcm-firmware` conviene
  chequear que sigan.
- Procedencia del firmware wifi: son bits propietarios de Apple,
  redistribuidos por un tercero. El PKGBUILD los baja de `mirror.funami.tech`
  con `sha256sums=('SKIP')` y los procesa con `asahi_firmware` de Asahi Linux.
  Sin firma ni checksum. Es lo que usa toda la comunidad t2linux, pero no esta
  verificado contra Apple. Ademas en esta maquina el IOMMU no hace DMA
  remapping (`iommu_groups` vacio, SWIOTLB), asi que el chip tiene DMA al host.
  Para verificar: extraer el mismo firmware de una imagen de recovery de Apple
  con `wiki.t2linux.org/tools/firmware.sh` y comparar sha256.
