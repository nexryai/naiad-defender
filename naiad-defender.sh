#!/bin/bash
cmd=$(zenity --list --title "naiad defender" --text="操作を選択してください。" --column "操作" フルスキャン 部分スキャン 定義データベースのアップデート 設定 )

if [ $cmd = 'フルスキャン' ]; then
  zenity --progress --text "お待ちください..." --pulsate & pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY clamscan -r -i /
fi

if [ $cmd = '部分スキャン' ]; then
  scan_dir=$(zenity --file-selection --directory --title "スキャンするディレクトリを選択してください")
  zenity --progress --text "お待ちください..." --pulsate & pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY clamscan -r -i $scan_dir
fi

if [ $cmd = '定義データベースのアップデート' ]; then
  zenity --progress --text "お待ちください..." --pulsate & pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY freshclam
fi

if [ $cmd = '設定' ]; then
  zenity --text-info --filename "/etc/clamav/clamd.conf"
fi

zenity --info --title "Done" --text "完了しました。"