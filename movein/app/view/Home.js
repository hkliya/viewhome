
Ext.define('MoveIn.view.Home', {
    extend: 'Ext.Carousel',
    alias: "widget.home",
	config: {
		title: "首页",
		items: [
			{
				xtype:'panel',
				layout: {
					type: 'vbox',
					align: 'center'
				},
				items: [
					{
					xtype: 'panel',
					margin: '0 0 0 0',
					defaults: {
						xtype: 'panel',
						layout: 'hbox',
						margin: '0 0 0 0',
						align: 'center'
					},
					items: [{
						defaults: {
							xtype: 'panel',
							margin: 0,
							style: 'border: 0px solid #cccccc; border-radius: 5px;text-align:center;'
						},
						items: [{
							html: '<img src="./image/dbsy.png" width="65" height="65" /><br/>待办事宜',
							xtype: "button",
							style: "background:none;border:0;width:105px;",
							badgeText: '2',
							handler: function(){
								view.push(Ext.widget("list"));
							}
						}, {
							html: '<img src="./image/bjsy.png" width="65" height="65" /><br/>已办事宜',
							xtype: "button",
							style: "background:none;border:0;width:105px;",
							handler: function(){
								view.push(Ext.widget("list"));
							}
						}, {
							html: '<img src="./image/email.png" width="65" height="65" /><br/>邮件',
							xtype: "button",
							style: "background:none;border:0;width:105px;",
							handler: function(){
								view.push(Ext.widget("list"));
							}
						}]
					}, {
						defaults: {
							xtype: 'panel',
							margin: 0,
							style: 'border: 0px solid #cccccc; border-radius: 5px;text-align:center;'
						},
						items: [{
							html: '<img src="./image/gwyl.png" width="65" height="65" /><br/>公文阅览',
							xtype: "button",
							style: "background:none;border:0;width:105px;",
							handler: function(){
								view.push(Ext.widget("file"));
							}
						}, {
							html: '<img src="./image/icon1.png" width="65" height="65" /><br/>栏目5',
							xtype: "button",
							style: "background:none;border:0;width:105px;",
							handler: function(){
								view.push(Ext.widget("file"));
							}
						}, {
							html: '<img src="./image/icon2.png" width="65" height="65" /><br/>栏目6',
							xtype: "button",
							style: "background:none;border:0;width:105px;",
							handler: function(){
								view.push(Ext.widget("file"));
							}
						}]
					}, {
						defaults: {
							xtype: 'panel',
							margin: 0,
							style: 'border: 0px solid #cccccc; border-radius: 5px;text-align:center;'
						},
						items: [{
							xtype: 'panel',
							margin: 0,
							html: '<img src="./image/icon6.png" width="65" height="65" /><br/>栏目7',
							xtype: "button",
							style: "background:none;border:0;width:105px;",
							handler: function(){
								view.push(Ext.widget("list"));
							}
						}, {
							xtype: 'panel',
							margin: 0,
							html: '<img src="./image/ykxx.png" width="65" height="65" /><br/>栏目8',
							xtype: "button",
							style: "background:none;border:0;width:105px;",
							handler: function(){
								view.push(Ext.widget("list"));
							}
						}, {
							xtype: 'panel',
							margin: 0,
							html: '<img src="./image/txl.png" width="65" height="65" /><br/>栏目9',
							xtype: "button",
							style: "background:none;border:0;width:105px;",
							handler: function(){
								view.push(Ext.widget("list"));
							}
						}]
					}]
				}]
			},
			{
				xtype:'panel',
				layout: {
					type: 'vbox',
					align: 'center'
				},
				items: [
					{
					xtype: 'panel',
					margin: '0 0 0 0',
					defaults: {
						xtype: 'panel',
						layout: 'hbox',
						margin: '0 0 0 0',
						align: 'center',
					},
					items: [{
						defaults: {
							xtype: 'panel',
							margin: 0,
							style: 'border: 0px solid #cccccc; border-radius: 5px;text-align:center;'
						},
						items: [{
							html: '<img src="./image/icon14.png" width="65" height="65" /><br/>日志',
							xtype: "button",
							id: "open-list",
							style: "background:none;border:0;width:105px;",
							handler: function(){
								view.push(Ext.widget("list"));
							}
						}, {
							html: '<img src="./image/icon13.png" width="65" height="65" /><br/>日程安排',
							xtype: "button",
							style: "background:none;border:0;width:105px;",
							handler: function(){
								view.push(Ext.widget("list"));
							}
						}, {
							html: '<img src="./image/icon1.png" width="65" height="65" /><br/>新建',
							xtype: "button",
							style: "background:none;border:0;width:105px;",
							handler: function(){
								view.push(Ext.widget("list"));
							}
						}]
					}]
				}]
			}
		]
    }

    
});