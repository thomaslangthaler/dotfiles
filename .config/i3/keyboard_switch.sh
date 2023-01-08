#!/bin/bash

if setxkbmap -print | grep -q '+us';
then
  setxkbmap -layout de;
elif setxkbmap -print | grep -q '+de';
then
  setxkbmap -layout us;
fi

