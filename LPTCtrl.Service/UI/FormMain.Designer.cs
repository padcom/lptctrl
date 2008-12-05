namespace LPTCtrl.Service.UI
{
    partial class FormMain {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing) {
            if (disposing && (components != null)) {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent() {
			this.components = new System.ComponentModel.Container();
			System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormMain));
			this.TrayIcon = new System.Windows.Forms.NotifyIcon(this.components);
			this.TrayIconMenu = new System.Windows.Forms.ContextMenuStrip(this.components);
			this.CloseMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.ActionTimer = new System.Windows.Forms.Timer(this.components);
			this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
			this.LaunchGUIMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.TrayIconMenu.SuspendLayout();
			this.SuspendLayout();
			// 
			// TrayIcon
			// 
			this.TrayIcon.ContextMenuStrip = this.TrayIconMenu;
			this.TrayIcon.Icon = ((System.Drawing.Icon)(resources.GetObject("TrayIcon.Icon")));
			this.TrayIcon.Text = "LPTCtrl Service";
			this.TrayIcon.Visible = true;
			// 
			// TrayIconMenu
			// 
			this.TrayIconMenu.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.LaunchGUIMenuItem,
            this.toolStripSeparator1,
            this.CloseMenuItem});
			this.TrayIconMenu.Name = "TrayIconMenu";
			this.TrayIconMenu.RenderMode = System.Windows.Forms.ToolStripRenderMode.System;
			this.TrayIconMenu.Size = new System.Drawing.Size(153, 76);
			// 
			// CloseMenuItem
			// 
			this.CloseMenuItem.Name = "CloseMenuItem";
			this.CloseMenuItem.Size = new System.Drawing.Size(152, 22);
			this.CloseMenuItem.Text = "&Close";
			this.CloseMenuItem.Click += new System.EventHandler(this.CloseMenuItem_Click);
			// 
			// ActionTimer
			// 
			this.ActionTimer.Enabled = true;
			this.ActionTimer.Interval = 1000;
			this.ActionTimer.Tick += new System.EventHandler(this.ActionTimer_Tick);
			// 
			// toolStripSeparator1
			// 
			this.toolStripSeparator1.Name = "toolStripSeparator1";
			this.toolStripSeparator1.Size = new System.Drawing.Size(149, 6);
			// 
			// LaunchGUIMenuItem
			// 
			this.LaunchGUIMenuItem.Name = "LaunchGUIMenuItem";
			this.LaunchGUIMenuItem.Size = new System.Drawing.Size(152, 22);
			this.LaunchGUIMenuItem.Text = "Launch GUI";
			this.LaunchGUIMenuItem.Click += new System.EventHandler(this.LaunchGUIMenuItem_Click);
			// 
			// FormMain
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(258, 186);
			this.Name = "FormMain";
			this.ShowIcon = false;
			this.ShowInTaskbar = false;
			this.Text = "LPTCtrl - Service";
			this.VisibleChanged += new System.EventHandler(this.FormMain_VisibleChanged);
			this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.FormMain_FormClosing);
			this.TrayIconMenu.ResumeLayout(false);
			this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.NotifyIcon TrayIcon;
        private System.Windows.Forms.Timer ActionTimer;
        private System.Windows.Forms.ContextMenuStrip TrayIconMenu;
        private System.Windows.Forms.ToolStripMenuItem CloseMenuItem;
		private System.Windows.Forms.ToolStripMenuItem LaunchGUIMenuItem;
		private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
    }
}