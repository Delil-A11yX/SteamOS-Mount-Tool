# SteamOS Easy Mount Tool 🛠️

Welcome! This is a simple one-click tool designed to help you permanently auto-mount any extra drive on your SteamOS device.

Whether you have an SD card, an internal Windows partition for dual-booting, or an external SSD, this tool will make it automatically appear and be ready to use every time you boot up.

### ✨ Features

* ✅ **Super Simple:** No complex terminal commands needed to get started.
* 🖱️ **One-Click Launcher:** Just download the launcher to your Desktop and run it.
* 🔄 **Update-Proof:** Your mounted drives will survive SteamOS updates.
* 🤖 **Automatic:** Set it once and forget it. Your drives will always be there when you boot up.

---

## 🚀 Step-by-Step Guide

Follow these steps carefully to get your drive set up.

### Step 1: Download the Launcher

First, you need to download the launcher file from this page.

1.  Look at the file list at the top of this GitHub page and click on the **`Easy-Mount-Tool.desktop`** file.
2.  On the next page, find and click the **"Download raw file"** button. It looks like a small downward-pointing arrow.
3.  Your browser will save the file to your **`Downloads`** folder.

![Download Step](https://i.imgur.com/8m1wNA8.png)

### Step 2: Move the Launcher to your Desktop

To make it easy to run, let's move the file you just downloaded.

1.  Open the **Dolphin File Manager** (it's the blue folder icon in your taskbar at the bottom of the screen).
2.  Go to your **`Downloads`** folder on the left side.
3.  Find the `Easy-Mount-Tool.desktop` file. Click it, hold the mouse button, drag it over to your Desktop, and let go.

### Step 3: Run the Tool

Now you can run the installer.

1.  **Double-click** the new "Easy Mount Tool" icon on your Desktop.
2.  A small window will pop up asking what to do with the file. Choose **"Execute"**.
3.  A graphical password prompt will appear. This is a necessary security step. Enter your **admin (sudo) password** and click OK.

### Step 4: Follow the On-Screen Instructions

That's it! A terminal window will now open and the script will guide you through the final steps.
1.  It will show you a list of all available drives.
2.  Choose the drive you want to mount by typing its number and pressing Enter.
3.  Give your drive a simple name (like `games` or `sdcard`) and press Enter.

The script will handle the rest automatically. After it's done, your drive will be permanently mounted and ready to use!

---

### 🤔 Troubleshooting

**Problem:** "When I double-click the file, it just opens in a text editor instead of asking to 'Execute'."

**Solution:** This can happen on some Linux setups. It means you need to give the file permission to run one time.
1.  **Right-click** the `Easy-Mount-Tool.desktop` file on your Desktop.
2.  Go to **Properties** -> **Permissions**.
3.  Check the box that says **"Is executable"**.
4.  Close the window and try double-clicking it again.
