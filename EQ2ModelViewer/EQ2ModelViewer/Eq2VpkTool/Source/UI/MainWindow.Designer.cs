namespace Eq2VpkTool
{
    public partial class MainWindow
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MainWindow));
            this.contextMenu = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.extractToolStripContextMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.extractWithPathInformationToolStripContextMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.decryptToolStripContextMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.openFileDialog = new System.Windows.Forms.OpenFileDialog();
            this.splitContainer = new System.Windows.Forms.SplitContainer();
            this.directoryTreeView = new System.Windows.Forms.TreeView();
            this.fileListView = new System.Windows.Forms.ListView();
            this.nameColumnHeader = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
            this.extractFolderDialog = new System.Windows.Forms.FolderBrowserDialog();
            this.mainMenu = new System.Windows.Forms.MenuStrip();
            this.fileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.mainFileOpenMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripMenuItem1 = new System.Windows.Forms.ToolStripSeparator();
            this.extractToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.extractWithPathInformationToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripMenuItem2 = new System.Windows.Forms.ToolStripSeparator();
            this.mainFileExitMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.helpToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.mainHelpWebsiteMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.aboutToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.statusMainPanelStrip = new System.Windows.Forms.StatusStrip();
            this.statusMainPanel = new System.Windows.Forms.ToolStripStatusLabel();
            this.splitContainer1 = new System.Windows.Forms.SplitContainer();
            this.contextMenu.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer)).BeginInit();
            this.splitContainer.Panel1.SuspendLayout();
            this.splitContainer.Panel2.SuspendLayout();
            this.splitContainer.SuspendLayout();
            this.mainMenu.SuspendLayout();
            this.statusMainPanelStrip.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).BeginInit();
            this.splitContainer1.Panel1.SuspendLayout();
            this.splitContainer1.Panel2.SuspendLayout();
            this.splitContainer1.SuspendLayout();
            this.SuspendLayout();
            // 
            // contextMenu
            // 
            this.contextMenu.AllowDrop = true;
            this.contextMenu.ImageScalingSize = new System.Drawing.Size(24, 24);
            this.contextMenu.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.extractToolStripContextMenuItem,
            this.extractWithPathInformationToolStripContextMenuItem,
            this.decryptToolStripContextMenuItem});
            this.contextMenu.Name = "contextMenuStrip1";
            this.contextMenu.Size = new System.Drawing.Size(326, 100);
            // 
            // extractToolStripContextMenuItem
            // 
            this.extractToolStripContextMenuItem.Enabled = false;
            this.extractToolStripContextMenuItem.Name = "extractToolStripContextMenuItem";
            this.extractToolStripContextMenuItem.Size = new System.Drawing.Size(325, 32);
            this.extractToolStripContextMenuItem.Text = "&Extract...";
            // 
            // extractWithPathInformationToolStripContextMenuItem
            // 
            this.extractWithPathInformationToolStripContextMenuItem.Enabled = false;
            this.extractWithPathInformationToolStripContextMenuItem.Name = "extractWithPathInformationToolStripContextMenuItem";
            this.extractWithPathInformationToolStripContextMenuItem.Size = new System.Drawing.Size(325, 32);
            this.extractWithPathInformationToolStripContextMenuItem.Text = "Extract with &path information...";
            // 
            // decryptToolStripContextMenuItem
            // 
            this.decryptToolStripContextMenuItem.Enabled = false;
            this.decryptToolStripContextMenuItem.Name = "decryptToolStripContextMenuItem";
            this.decryptToolStripContextMenuItem.Size = new System.Drawing.Size(325, 32);
            this.decryptToolStripContextMenuItem.Text = "Decrypt and extract...";
            this.decryptToolStripContextMenuItem.Visible = false;
            // 
            // openFileDialog
            // 
            this.openFileDialog.DefaultExt = "vpl";
            this.openFileDialog.Filter = "VPL files|*.vpl|All files|*.*";
            this.openFileDialog.Title = "Open VPL File...";
            // 
            // splitContainer
            // 
            this.splitContainer.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer.Location = new System.Drawing.Point(0, 0);
            this.splitContainer.Name = "splitContainer";
            // 
            // splitContainer.Panel1
            // 
            this.splitContainer.Panel1.Controls.Add(this.directoryTreeView);
            // 
            // splitContainer.Panel2
            // 
            this.splitContainer.Panel2.Controls.Add(this.fileListView);
            this.splitContainer.Size = new System.Drawing.Size(592, 422);
            this.splitContainer.SplitterDistance = 200;
            this.splitContainer.TabIndex = 14;
            // 
            // directoryTreeView
            // 
            this.directoryTreeView.ContextMenuStrip = this.contextMenu;
            this.directoryTreeView.Dock = System.Windows.Forms.DockStyle.Fill;
            this.directoryTreeView.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.directoryTreeView.FullRowSelect = true;
            this.directoryTreeView.HideSelection = false;
            this.directoryTreeView.Location = new System.Drawing.Point(0, 0);
            this.directoryTreeView.MinimumSize = new System.Drawing.Size(100, 0);
            this.directoryTreeView.Name = "directoryTreeView";
            this.directoryTreeView.PathSeparator = "/";
            this.directoryTreeView.Size = new System.Drawing.Size(200, 422);
            this.directoryTreeView.Sorted = true;
            this.directoryTreeView.TabIndex = 4;
            this.directoryTreeView.AfterSelect += new System.Windows.Forms.TreeViewEventHandler(this.directoryTreeView_AfterSelect);
            this.directoryTreeView.Enter += new System.EventHandler(this.directoryTreeView_Enter);
            this.directoryTreeView.MouseUp += new System.Windows.Forms.MouseEventHandler(this.directoryTreeView_MouseUp);
            // 
            // fileListView
            // 
            this.fileListView.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.nameColumnHeader});
            this.fileListView.ContextMenuStrip = this.contextMenu;
            this.fileListView.Dock = System.Windows.Forms.DockStyle.Fill;
            this.fileListView.FullRowSelect = true;
            this.fileListView.HideSelection = false;
            this.fileListView.Location = new System.Drawing.Point(0, 0);
            this.fileListView.Name = "fileListView";
            this.fileListView.Size = new System.Drawing.Size(388, 422);
            this.fileListView.TabIndex = 9;
            this.fileListView.UseCompatibleStateImageBehavior = false;
            this.fileListView.View = System.Windows.Forms.View.Details;
            this.fileListView.ItemSelectionChanged += new System.Windows.Forms.ListViewItemSelectionChangedEventHandler(this.fileListView_ItemSelectionChanged);
            this.fileListView.Enter += new System.EventHandler(this.fileListView_Enter);
            this.fileListView.MouseUp += new System.Windows.Forms.MouseEventHandler(this.fileListView_MouseUp);
            // 
            // nameColumnHeader
            // 
            this.nameColumnHeader.Text = "Name";
            this.nameColumnHeader.Width = 350;
            // 
            // extractFolderDialog
            // 
            this.extractFolderDialog.Description = "Select a folder to extract the selected items to.";
            // 
            // mainMenu
            // 
            this.mainMenu.GripMargin = new System.Windows.Forms.Padding(2, 2, 0, 2);
            this.mainMenu.ImageScalingSize = new System.Drawing.Size(24, 24);
            this.mainMenu.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.fileToolStripMenuItem,
            this.helpToolStripMenuItem});
            this.mainMenu.Location = new System.Drawing.Point(0, 0);
            this.mainMenu.Name = "mainMenu";
            this.mainMenu.Size = new System.Drawing.Size(592, 33);
            this.mainMenu.TabIndex = 5;
            this.mainMenu.ItemClicked += new System.Windows.Forms.ToolStripItemClickedEventHandler(this.mainMenu_ItemClicked);
            // 
            // fileToolStripMenuItem
            // 
            this.fileToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.mainFileOpenMenuItem,
            this.toolStripMenuItem1,
            this.extractToolStripMenuItem,
            this.extractWithPathInformationToolStripMenuItem,
            this.toolStripMenuItem2,
            this.mainFileExitMenuItem});
            this.fileToolStripMenuItem.Name = "fileToolStripMenuItem";
            this.fileToolStripMenuItem.Size = new System.Drawing.Size(54, 29);
            this.fileToolStripMenuItem.Text = "&File";
            // 
            // mainFileOpenMenuItem
            // 
            this.mainFileOpenMenuItem.Name = "mainFileOpenMenuItem";
            this.mainFileOpenMenuItem.Size = new System.Drawing.Size(355, 34);
            this.mainFileOpenMenuItem.Text = "&Open VPL file...";
            this.mainFileOpenMenuItem.Click += new System.EventHandler(this.mainFileOpenMenuItem_Click);
            // 
            // toolStripMenuItem1
            // 
            this.toolStripMenuItem1.Name = "toolStripMenuItem1";
            this.toolStripMenuItem1.Size = new System.Drawing.Size(352, 6);
            // 
            // extractToolStripMenuItem
            // 
            this.extractToolStripMenuItem.Enabled = false;
            this.extractToolStripMenuItem.Name = "extractToolStripMenuItem";
            this.extractToolStripMenuItem.Size = new System.Drawing.Size(355, 34);
            this.extractToolStripMenuItem.Text = "&Extract...";
            this.extractToolStripMenuItem.Click += new System.EventHandler(this.extractToolStripMenuItem_Click);
            // 
            // extractWithPathInformationToolStripMenuItem
            // 
            this.extractWithPathInformationToolStripMenuItem.Enabled = false;
            this.extractWithPathInformationToolStripMenuItem.Name = "extractWithPathInformationToolStripMenuItem";
            this.extractWithPathInformationToolStripMenuItem.Size = new System.Drawing.Size(355, 34);
            this.extractWithPathInformationToolStripMenuItem.Text = "Extract with &path information...";
            this.extractWithPathInformationToolStripMenuItem.Click += new System.EventHandler(this.extractWithPathInformationToolStripMenuItem_Click);
            // 
            // toolStripMenuItem2
            // 
            this.toolStripMenuItem2.Name = "toolStripMenuItem2";
            this.toolStripMenuItem2.Size = new System.Drawing.Size(352, 6);
            // 
            // mainFileExitMenuItem
            // 
            this.mainFileExitMenuItem.Name = "mainFileExitMenuItem";
            this.mainFileExitMenuItem.Size = new System.Drawing.Size(355, 34);
            this.mainFileExitMenuItem.Text = "E&xit";
            this.mainFileExitMenuItem.Click += new System.EventHandler(this.mainFileExitMenuItem_Click);
            // 
            // helpToolStripMenuItem
            // 
            this.helpToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.mainHelpWebsiteMenuItem,
            this.aboutToolStripMenuItem});
            this.helpToolStripMenuItem.Name = "helpToolStripMenuItem";
            this.helpToolStripMenuItem.Size = new System.Drawing.Size(65, 29);
            this.helpToolStripMenuItem.Text = "&Help";
            // 
            // mainHelpWebsiteMenuItem
            // 
            this.mainHelpWebsiteMenuItem.Name = "mainHelpWebsiteMenuItem";
            this.mainHelpWebsiteMenuItem.Size = new System.Drawing.Size(189, 34);
            this.mainHelpWebsiteMenuItem.Text = "&Website...";
            this.mainHelpWebsiteMenuItem.Click += new System.EventHandler(this.mainHelpWebsiteMenuItem_Click);
            // 
            // aboutToolStripMenuItem
            // 
            this.aboutToolStripMenuItem.Name = "aboutToolStripMenuItem";
            this.aboutToolStripMenuItem.Size = new System.Drawing.Size(189, 34);
            this.aboutToolStripMenuItem.Text = "&About...";
            this.aboutToolStripMenuItem.Click += new System.EventHandler(this.aboutToolStripMenuItem_Click);
            // 
            // statusMainPanelStrip
            // 
            this.statusMainPanelStrip.ImageScalingSize = new System.Drawing.Size(24, 24);
            this.statusMainPanelStrip.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.statusMainPanel});
            this.statusMainPanelStrip.Location = new System.Drawing.Point(0, 451);
            this.statusMainPanelStrip.Name = "statusMainPanelStrip";
            this.statusMainPanelStrip.Size = new System.Drawing.Size(592, 22);
            this.statusMainPanelStrip.TabIndex = 15;
            // 
            // statusMainPanel
            // 
            this.statusMainPanel.Name = "statusMainPanel";
            this.statusMainPanel.Size = new System.Drawing.Size(0, 15);
            // 
            // splitContainer1
            // 
            this.splitContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer1.FixedPanel = System.Windows.Forms.FixedPanel.Panel1;
            this.splitContainer1.IsSplitterFixed = true;
            this.splitContainer1.Location = new System.Drawing.Point(0, 0);
            this.splitContainer1.Name = "splitContainer1";
            this.splitContainer1.Orientation = System.Windows.Forms.Orientation.Horizontal;
            // 
            // splitContainer1.Panel1
            // 
            this.splitContainer1.Panel1.Controls.Add(this.mainMenu);
            // 
            // splitContainer1.Panel2
            // 
            this.splitContainer1.Panel2.Controls.Add(this.splitContainer);
            this.splitContainer1.Size = new System.Drawing.Size(592, 451);
            this.splitContainer1.SplitterDistance = 25;
            this.splitContainer1.TabIndex = 10;
            // 
            // MainWindow
            // 
            this.AutoScaleBaseSize = new System.Drawing.Size(8, 19);
            this.ClientSize = new System.Drawing.Size(592, 473);
            this.Controls.Add(this.splitContainer1);
            this.Controls.Add(this.statusMainPanelStrip);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MinimumSize = new System.Drawing.Size(480, 292);
            this.Name = "MainWindow";
            this.Text = "Eq2VpkTool";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.MainWindow_FormClosing);
            this.contextMenu.ResumeLayout(false);
            this.splitContainer.Panel1.ResumeLayout(false);
            this.splitContainer.Panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer)).EndInit();
            this.splitContainer.ResumeLayout(false);
            this.mainMenu.ResumeLayout(false);
            this.mainMenu.PerformLayout();
            this.statusMainPanelStrip.ResumeLayout(false);
            this.statusMainPanelStrip.PerformLayout();
            this.splitContainer1.Panel1.ResumeLayout(false);
            this.splitContainer1.Panel1.PerformLayout();
            this.splitContainer1.Panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).EndInit();
            this.splitContainer1.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.OpenFileDialog openFileDialog;
        private System.Windows.Forms.SplitContainer splitContainer;
        private System.Windows.Forms.FolderBrowserDialog extractFolderDialog;
        private System.Windows.Forms.ContextMenuStrip contextMenu;
        private System.Windows.Forms.ToolStripMenuItem extractToolStripContextMenuItem;
        private System.Windows.Forms.ToolStripMenuItem extractWithPathInformationToolStripContextMenuItem;
        private System.Windows.Forms.ToolStripMenuItem decryptToolStripContextMenuItem;
        private System.Windows.Forms.MenuStrip mainMenu;
        private System.Windows.Forms.ToolStripMenuItem fileToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem mainFileOpenMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem extractToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem extractWithPathInformationToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripMenuItem2;
        private System.Windows.Forms.ToolStripMenuItem mainFileExitMenuItem;
        private System.Windows.Forms.ToolStripMenuItem helpToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem mainHelpWebsiteMenuItem;
        private System.Windows.Forms.ToolStripMenuItem aboutToolStripMenuItem;
        private System.Windows.Forms.StatusStrip statusMainPanelStrip;
        private System.Windows.Forms.ToolStripStatusLabel statusMainPanel;
        private System.Windows.Forms.TreeView directoryTreeView;
        private System.Windows.Forms.ListView fileListView;
        private System.Windows.Forms.ColumnHeader nameColumnHeader;
        private System.Windows.Forms.SplitContainer splitContainer1;
    }
}

