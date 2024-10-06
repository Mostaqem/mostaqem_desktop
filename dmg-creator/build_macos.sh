app_path="build/macos/Build/Products/Release/Mostaqem.app";
dev_email='ismailalamkhan@icloud.com';
dev_id='Apple Development: ismailalamkhan@icloud.com (MMN4P53468)';
dmg_name="mostaqem-macos.dmg";

echo "- Building macOS app:";
flutter build macos;

echo "- Checking codesigning identity:";
security find-identity -p codesigning -v

echo "- Unlocking Keychain:";
security unlock-keychain -p '' ~/Library/Keychains/build.keychain

echo "- Code Signing APP:";
sudo codesign --deep --force --verify --verbose --sign "$dev_id" --options runtime "$app_path"

echo "- Code Sign APP verification:";
codesign --verify --verbose "$app_path"

echo "- Creating DMG:";
cd "./dmg-creator";

# removing DMG if exists.
rm "$dmg_name";

appdmg ./config.json "$dmg_name";
# cd "../../";


# as we move from the folder, keep a reference to the DMG path
dmg_path="./$dmg_name";

echo "- Code Signing DMG:";
sudo codesign --deep --force --verify --verbose --sign "$dev_id" --options runtime "$dmg_path";

echo "- Code Signing DMG verification:";
codesign --verify --verbose "$dmg_path"

echo "- Copy to root:";
cp "$dmg_path" "../"
