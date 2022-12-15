# RclexOnNervesOnF3rp70

Rclex on Nerves on F3RP70 (e-RT3 Plus from Yokogawa Electric Corporation)

2022/12/17 開催の「第11回FA設備技術勉強会」のデモ向けリポジトリ  
https://fa-study.connpass.com/event/260896/

## 対象とする環境

- elixir 1.14.0-otp-25
- erlang 25.0.4
- ボード：横河電機 [リアルタイムOSコントローラ e-RT3 Plus](https://www.yokogawa.co.jp/solutions/products-and-services/control/control-devices/real-time-os-controller/)

ElixirのROS 2クライアントライブラリである [Rclex](https://hex.pm/packages/rclex) が，ナウでヤングでcoolなIoTプラットフォームである [Nerves](https://www.nerves-project.org/) 上でいごきます！  
FA設備技術勉強会のデモ向けに e-RT3 Plus を対象としていますが，[Nerves対応のIoTボード](https://hexdocs.pm/nerves/targets.html)であれば他のものでもいごくはずです，しらんけど．

## 使用方法

### ビルド

```
git clone https://github.com/b5g-ex/rclex_on_nerves_on_f3rp70
cd rclex_on_nerves_on_f3rp70
export MIX_TARGET=f3rp70
mix deps.get
export ROS_DISTRO=foxy
mix rclex.prep.ros2 --arch arm32v7
mix rclex.gen.msgs
mix firmware
mix burn   # or, mix upload
```

### 実行

#### RclexTalker

```
ssh nerves.local
iex()> RclexOnNervesOnF3RP70.RclexTalker.publish_message
```

詳細は [rclex_examples/rclex_talker](https://github.com/rclex/rclex_examples/tree/main/rclex_talker) を参照してください．

#### RclexListener

```
ssh nerves.local
iex()> RclexOnNervesOnF3RP70.RclexListener.subscribe_message
```

詳細は [rclex_examples/rclex_listener](https://github.com/rclex/rclex_examples/tree/main/rclex_listener) を参照してください．

#### TeleopKey

```
ssh nerves.local
iex()> RclexOnNervesOnF3RP70.TeleopKey.start_teleop
```

詳細は [rclex_examples/turtle_teleop_rclex](https://github.com/rclex/rclex_examples/tree/main/turtle_teleop_rclex#teleoperation-from-key-input) を参照してください．

#### SubPose

```
ssh nerves.local
iex()> RclexOnNervesOnF3RP70.SubPose.start_pose(10000)
```

詳細は [rclex_examples/turtle_teleop_rclex](https://github.com/rclex/rclex_examples/tree/main/turtle_teleop_rclex#subsription-of-pose) を参照してください．

## Awesome links!!

* [Nerves Project](https://www.nerves-project.org/)
* [ROS 2 (Robot Operating System 2)](https://docs.ros.org/en/foxy/index.html)
* [pojiro/nerves_system_f3rp70](https://github.com/pojiro/nerves_system_f3rp70)
* [rclex/rclex](https://github.com/rclex/rclex)
* [rclex/rclex_examples](https://github.com/rclex/rclex_examples)
* [b5g-ex/rclex_on_nerves](https://github.com/b5g-ex/rclex_on_nerves)
