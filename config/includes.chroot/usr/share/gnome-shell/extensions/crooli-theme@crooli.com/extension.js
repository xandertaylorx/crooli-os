// Crooli OS shell: the Crooli menu in the top bar, and a quieter panel.
// stylesheet.css next to this file is loaded automatically by GNOME Shell.
import GObject from 'gi://GObject';
import Gio from 'gi://Gio';
import St from 'gi://St';
import {Extension} from 'resource:///org/gnome/shell/extensions/extension.js';
import * as Main from 'resource:///org/gnome/shell/ui/main.js';
import * as PanelMenu from 'resource:///org/gnome/shell/ui/panelMenu.js';
import * as PopupMenu from 'resource:///org/gnome/shell/ui/popupMenu.js';
import * as Util from 'resource:///org/gnome/shell/misc/util.js';

const CrooliMenu = GObject.registerClass(
class CrooliMenu extends PanelMenu.Button {
    _init(extensionPath) {
        super._init(0.0, 'Crooli menu', false);
        this.add_style_class_name('crooli-menu-button');

        const icon = new St.Icon({
            gicon: Gio.icon_new_for_string(`${extensionPath}/icons/crooli.svg`),
            icon_size: 16,
            style_class: 'crooli-logo',
        });
        this.add_child(icon);

        const run = (...argv) => () => Util.spawn(argv);

        this.menu.addAction('About Crooli OS', run('gnome-control-center', 'system'));
        this.menu.addMenuItem(new PopupMenu.PopupSeparatorMenuItem());
        this.menu.addAction('Settings…', run('gnome-control-center'));
        this.menu.addAction('App Store…', run('gnome-software'));
        this.menu.addAction('Check for Updates…', run('gnome-software', '--mode=updates'));
        this.menu.addAction('Welcome', run('crooli-welcome'));
        this.menu.addMenuItem(new PopupMenu.PopupSeparatorMenuItem());
        this.menu.addAction('Sleep', run('systemctl', 'suspend'));
        this.menu.addAction('Restart…', run('gnome-session-quit', '--reboot'));
        this.menu.addAction('Shut Down…', run('gnome-session-quit', '--power-off'));
        this.menu.addMenuItem(new PopupMenu.PopupSeparatorMenuItem());
        this.menu.addAction('Log Out…', run('gnome-session-quit', '--logout'));
    }
});

export default class CrooliShell extends Extension {
    enable() {
        this._button = new CrooliMenu(this.path);
        Main.panel.addToStatusArea('crooli-menu', this._button, 0, 'left');

        // The Crooli menu replaces the "Activities" label. The Super key and
        // the screen corner still open the overview.
        this._activities = Main.panel.statusArea.activities ?? null;
        this._activities?.hide();
    }

    disable() {
        this._activities?.show();
        this._activities = null;
        this._button?.destroy();
        this._button = null;
    }
}
