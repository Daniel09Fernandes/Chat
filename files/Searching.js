// JavaScript Document// vim: ts=4:sw=4:nu:fdc=4:nospell
/**
 * Search plugin for Ext.grid.GridPanel, Ext.grid.EditorGrid ver. 2.x or subclasses of them
 *
 * @author    Ing. Jozef Sakalos
 * @copyright (c) 2008, by Ing. Jozef Sakalos
 * @date      17. January 2008
 * @version   $Id: Ext.ux.grid.Search.js 220 2008-04-29 21:46:51Z jozo $
 *
 * @license Ext.ux.grid.Search is licensed under the terms of
 * the Open Source LGPL 3.0 license.  Commercial use is permitted to the extent
 * that the code/component(s) do NOT become part of another Open Source or Commercially
 * licensed development library or toolkit without explicit permission.
 *
 * License details: http://www.gnu.org/licenses/lgpl.html
 */

/*
	Revised for Ext 4
	by Nathan LeBlanc
	on July 8, 2011
*/

/**
 * Patches for Ext 4.2 copied from forums by Berend de Boer, August 12, 2013.
 */

/**
 *  Adapt  for UniGui 0.096.. Aplications   by Salvatore Marullo, August 2014.
 */

 Ext.Loader.setConfig({
    enabled : true,
    paths: {

            'Ext.ux.grid.feature' : 'files/'         // extension namespace folder/files
    }
});


Ext.define('Ext.ux.grid.feature.Searching', {
    extend: 'Ext.grid.feature.Feature',
    alias: 'feature.searching',

	/**
	 * cfg {Boolean} autoFocus true to try to focus the input field on each store load (defaults to undefined)
	 */

	/**
	 * @cfg {String} searchText Text to display on menu button
	 */

	searchText:'Search',

	/**
	 * @cfg {String} searchTipText Text to display as input tooltip. Set to '' for no tooltip
	 */
	searchTipText:'Type a text to search and press Enter',

	/**
	 * @cfg {String} selectAllText Text to display on menu item that selects all fields
	 */
	selectAllText:'Select All',

	/**
	 * @cfg {String} position Where to display the search controls. Valid values are top and bottom (defaults to bottom)
	 * Corresponding toolbar has to exist at least with mimimum configuration tbar:[] for position:top or bbar:[]
	 * for position bottom. Plugin does NOT create any toolbar.
	 */
	position:'bottom',

	/**
	 * @cfg {String} iconCls Icon class for menu button (defaults to icon-magnifier)
	 */
	iconCls:'icon-magnifier',

	/**
	 * @cfg {String/Array} checkIndexes Which indexes to check by default. Can be either 'all' for all indexes
	 * or array of dataIndex names, e.g. ['persFirstName', 'persLastName']
	 */
	checkIndexes:'all',
    /**
	 * @cfg {Array} disableIndexes Array of index names to disable (not show in the menu), e.g. ['persTitle', 'persTitle2']
	 */
	disableIndexes:[],

	/**
	 * @cfg {String} dateFormat how to format date values. If undefined (the default)
	 * date is formatted as configured in colummn model
	 */
	dateFormat:undefined,

	/**
	 * @cfg {Boolean} showSelectAll Select All item is shown in menu if true (defaults to true)
	 */
	showSelectAll:true,

	/**
	 * @cfg {String} menuStyle Valid values are 'checkbox' and 'radio'. If menuStyle is radio
	 * then only one field can be searched at a time and selectAll is automatically switched off.
	 */
	menuStyle:'checkbox',
    minChars:0,
	/**
	 * @cfg {Number} minChars minimum characters to type before the request is made. If undefined (the default)
	 * the trigger field shows magnifier icon and you need to click it or press enter for search to start. If it
	 * is defined and greater than 0 then maginfier is not shown and search starts after minChars are typed.
	 */

	/**
	 * @cfg {String} minCharsTipText Tooltip to display if minChars is > 0
	 */
	minCharsTipText:'Type at least {0} characters',

	/**
	 * @cfg {String} mode Use 'remote' for remote stores or 'local' for local stores. If mode is local
	 * no data requests are sent to server the grid's store is filtered instead (defaults to 'remote')
	 */
	mode:'local',

	/**
	 * @cfg {Array} readonlyIndexes Array of index names to disable (show in menu disabled), e.g. ['persTitle', 'persTitle2']
	 */

	/**
	 * @cfg {Number} width Width of input field in pixels (defaults to 100)
	 */
	width:300,

	/**
	 * @cfg {Object} paramNames Params name map (defaults to {fields:'fields', query:'query'}
	 */
	paramNames: {
		 fields:'fields'
		,query:'query'
	},

	/**
	 * @cfg {String} shortcutKey Key to fucus the input field (defaults to r = Sea_r_ch). Empty string disables shortcut
	 */
	shortcutKey:'r',

	/**
	 * @cfg {String} shortcutModifier Modifier for shortcutKey. Valid values: alt, ctrl, shift (defaults to alt)
	 */
	shortcutModifier:'alt',

	/**
	 * @cfg {String} align 'left' or 'right' (defaults to 'left')
	 */

	/**
	 * @cfg {Number} minLength force user to type this many character before he can make a search
	 */
     minLength:2,

	 reconfigureColsMenu : false,
	 trigger1ButtonTip   : 'Clear Search',
	 trigger2ButtonTip   : 'Search',
     trigger3ButtonTip   : 'Reconfigure Search Menu',

	/**
	 * @cfg {Ext.Panel/String} toolbarContainer Panel (or id of the panel) which contains toolbar we want to render
	 * search controls to (defaults to this.grid, the grid this plugin is plugged-in into)
	 */

	init: function(grid) {


     this.grid = grid;
	 this.mode = 'local' ;

     if(this.grid.rendered)
        this.onRender();
     else
        this.grid.on('render', this.onRender, this);


    },



	onRender:function() {

		var panel = this.toolbarContainer || this.grid;
		var tb = 'bottom' === this.position ? panel.getDockedItems('PagingTool[dock="bottom"]') : panel.getDockedItems('PagingTool[dock="top"]');

		if(tb.length > 0)
			tb = tb[0]
		else {
			tb = Ext.create('Ext.toolbar.Toolbar', {dock: this.position});
			panel.addDocked(tb);

		}

		// add menu
		this.menu = Ext.create('Ext.menu.Menu');

		// handle position
		if('right' === this.align) {
			tb.add('->');
		}
		else {
			if(0 < tb.items.getCount()) {
				tb.add('-');
			}
		}

		// add menu button
		tb.add({
			 text:this.searchText
			,menu:this.menu
			,iconCls:this.iconCls
		});

		// add input field (TriggerField )

         if ( this.reconfigureColsMenu === true ) {
         this.field = Ext.create('Ext.form.field.Trigger', {
            cls:  "grid-search",
			width: this.width,
			qtip: 'ddd',
			selectOnFocus: undefined === this.selectOnFocus ? true : this.selectOnFocus,
			trigger1Cls:'x-form-clear-trigger',
		    trigger2Cls:this.minChars ? 'x-hidden' : 'x-form-search-trigger',
			trigger3Cls:'x-form-std-trigger',
			onTrigger1Click: Ext.bind(this.onTriggerClear, this),
			onTrigger2Click: this.minChars ? Ext.emptyFn : Ext.bind(this.onTriggerSearch, this),
			onTrigger3Click: Ext.bind(this.onTriggerReset, this),
			minLength:this.minLength
		});
		}
		else {

         this.field = Ext.create('Ext.form.field.Trigger', {
            cls:  "grid-search",
			width: this.width,
			qtip: 'ddd',
			selectOnFocus: undefined === this.selectOnFocus ? true : this.selectOnFocus,
			trigger1Cls:'x-form-clear-trigger',
		    trigger2Cls:this.minChars ? 'x-hidden' : 'x-form-search-trigger',

			onTrigger1Click: Ext.bind(this.onTriggerClear, this),
			onTrigger2Click: this.minChars ? Ext.emptyFn : Ext.bind(this.onTriggerSearch, this),

			minLength:this.minLength
		});

		}



		// install event handlers on input field
		this.field.on('render', function() {

             var qtip = this.minChars ? Ext.String.format(this.minCharsTipText, this.minChars) : this.searchTipText;

			 var divClass =  Ext.query('.'+this.field.trigger1Cls); // retturn obj
			 HtmlEle = divClass[0] ;
             trigger1target = HtmlEle.id ;

			 var divClass =  Ext.query('.'+this.field.trigger2Cls); // retturn obj
			 HtmlEle = divClass[0] ;
             trigger2target = HtmlEle.id ;

            if ( this.reconfigureColsMenu === true ) {
              var divClass =  Ext.query('.'+this.field.trigger3Cls); // retturn obj
			  HtmlEle = divClass[0] ;
              trigger3target = HtmlEle.id ;

              var tooltips = [{
               target: this.field.inputEl,
			   trackMouse: true,
			   anchor: 'bottom',
			   html: qtip
              },{
             target: trigger1target,
			   anchor: 'bottom',
               anchorOffset:-15,
			   html: this.trigger1ButtonTip
              },
			  {
               target: trigger2target,
			   anchor: 'bottom',
               anchorOffset:-15,
			   html: this.trigger2ButtonTip
              },
              {
               target: trigger3target,
			   anchor: 'bottom',
               anchorOffset:-15,
			   html: this.trigger3ButtonTip
              }
			  ];
             }  // end if
			 else {

			 var tooltips = [{
               target: this.field.inputEl,
			   trackMouse: true,
			   anchor: 'bottom',
			   html: qtip
              },{
             target: trigger1target,
			   anchor: 'bottom',
               anchorOffset:-15,
			   html: this.trigger1ButtonTip
              },
			  {
               target: trigger2target,
			   anchor: 'bottom',
               anchorOffset:-15,
			   html: this.trigger2ButtonTip
              }

			  ];


             }


			  Ext.each(tooltips, function(config) {
                Ext.create('Ext.tip.ToolTip', config);
              });



              Ext.QuickTips.init();


			if(this.minChars) {
				this.field.el.on({scope:this, buffer:300, keyup:this.onKeyUp});
			}

			// install key map
			var map = new Ext.KeyMap(this.field.el, [{
				 key:Ext.EventObject.ENTER
				,scope:this
				,fn:this.onTriggerSearch
			},{
				 key:Ext.EventObject.ESC
				,scope:this
				,fn:this.onTriggerClear
			}]);
			map.stopEvent = true;
		}, this, {single:true});

		tb.add(this.field);


		// reconfigure
		this.reconfigure();

		// keyMap
		if(this.shortcutKey && this.shortcutModifier) {
			var shortcutEl = this.grid.getEl();
			var shortcutCfg = [{
				 key:this.shortcutKey
				,scope:this
				,stopEvent:true
				,fn:function() {
					this.field.focus();
				}
			}];
			shortcutCfg[0][this.shortcutModifier] = true;
			this.keymap = new Ext.KeyMap(shortcutEl, shortcutCfg);
		}

		if(true === this.autoFocus) {
			this.grid.store.on({scope:this, load:function(){this.field.focus();}});
		}
	} // eo function onRender
	// }}}
	// {{{
	/**
	 * field el keypup event handler. Triggers the search
	 * @private
	 */
	,onKeyUp:function() {
		var length = this.field.getValue().toString().length;

		if(0 === length || this.minChars <= length) {
			this.onTriggerSearch();
		}
	} // eo function onKeyUp
	// }}}
	// {{{
	/**
	 * private Clear Trigger click handler
	 */

	,onTriggerClear:function() {

		if(this.field.getValue()) {
			this.field.setValue('');
			this.field.focus();
			this.onTriggerSearch();
		}
	} // eo function onTriggerClear
	,onTriggerReset:function() {

	  checkIndexes = My.Columns.Fields;
	  this.reconfigure();
	} // eo function onTriggerReset

	// }}}
	// {{{
	/**
	 * private Search Trigger click handler (executes the search, local or remote)
	 */
	,onTriggerSearch:function() {
		if(!this.field.isValid()) {
			return;
		}
		var val = this.field.getValue(),
		 store = this.grid.store;

		// grid's store filter
		 gridColumns = this.grid.headerCt.getGridColumns();

         var ItemsCount = 0 ;
		 var SelAll  = false ;
		 this.menu.items.each(function(item) {
						if(item.checked && item.text !== this.selectAllText)  {
							ItemsCount = ItemsCount + 1;
						}

					 	if(item.checked && item.text === this.selectAllText )  {
							SelAll = true;
						}
						},this

		);

		if('local' === this.mode &&  ItemsCount > 0 ) {
			store.clearFilter();

			if(val) {
				store.filterBy(function(r) {
					var retval = false;
					this.menu.items.each(function(item) {
						if(!item.checked || retval) {
							return;
						}
						if (item.text !== this.selectAllText) {

					    item.dataIndex = My.Columns.Fields.indexOf(item.text);
						//alert(My.Columns.Fields[item.dataIndex]) ;
						var rv = r.get(item.dataIndex);
						rv = rv instanceof Date ? Ext.Date.format(rv, this.dateFormat || r.fields.get(item.dataIndex).dateFormat) : rv;
						var re = new RegExp(val, 'gi');
						retval = re.test(rv);
						}
					}, this);
					if(retval) {
						return true;
					}
					return retval;
				}, this);
			}
			else {
			}
		}
        else {


		if('local' === this.mode && ItemsCount === 0  &&  SelAll === true) {

			store.clearFilter();

			if(val) {

				store.filterBy(function(r) {

					var retval = false;

				    for (i = 0; i < gridColumns.length; i++) {



                        if(retval) {

							{break }
						}


						var rv = r.get(i);

                        rv = rv instanceof Date ? Ext.Date.format(rv, this.dateFormat || r.fields.get(i).dateFormat) : rv;
						var re = new RegExp(val, 'gi');
						retval = re.test(rv);

					}
					if(retval) {
						return true;
					}
					return retval;
				},this)
			}
			else {
			}
		}
		else {
		  Ext.MessageBox.show({ msg:'Please make a Selection-Search.',buttons:Ext.MessageBox.OK,animel:'bm9', maxWidth:300,
           fn:showResult , icon:Ext.MessageBox.WARNING});

          function showResult(btn){
            }
		}
        // fine
		}




	} // eo function onTriggerSearch
	// }}}
	// {{{
	/**
	 * @param {Boolean} true to disable search (TwinTriggerField), false to enable
	 */
	,setDisabled:function() {
		this.field.setDisabled.apply(this.field, arguments);
	} // eo function setDisabled
	// }}}
	// {{{
	/**
	 * Enable search (TwinTriggerField)
	 */
	,enable:function() {
		this.setDisabled(false);
	} // eo function enable
	// }}}
	// {{{
	/**
	 * Enable search (TwinTriggerField)
	 */
	,disable:function() {
		this.setDisabled(true);
	} // eo function disable
	// }}}
	// {{{
	/**
	 * private (re)configures the plugin, creates menu items from column model
	 */
	,reconfigure:function() {

		// {{{
		// remove old items
		var menu = this.menu;
		menu.removeAll();


		// add Select All item plus separator
		if(this.showSelectAll && 'radio' !== this.menuStyle) {

			menu.add({
				xtype: 'menucheckitem',
				text:this.selectAllText,
				checked:(this.checkIndexes instanceof Array),
				hideOnClick:false,
				handler:function(item) {

					var checked = item.checked;
					item.parentMenu.items.each(function(i) {
						if(item !== i && i.setChecked && !i.disabled) {
							i.setChecked(checked);
						}
					});
				}
			},'-');
            var group = undefined;
		    if(this.checkIndexes instanceof Array) {
			  for (i = 0; i < this.checkIndexes.length; i++) {
			     	menu.add({
						xtype: 'menucheckitem',
						text:  this.checkIndexes[i],
						hideOnClick: false,
						group:group,
						checked: true,
						dataIndex: i,
					});

              }
			}


		}

		var columns = this.grid.headerCt.items.items;
		var group = undefined;
		if('radio' === this.menuStyle) {
			group = 'g' + (new Date).getTime();
		}

		Ext.each(columns, function(column) {
			var disable = false;
			if(column.text && column.dataIndex && column.dataIndex != '') {
				Ext.each(this.disableIndexes, function(item) {
					disable = disable ? disable : item === column.dataIndex;
				});
				if(!disable) {
					menu.add({
						xtype: 'menucheckitem',
						text: column.text,
						hideOnClick: false,
						group:group,
						checked: 'all' === this.checkIndexes,
						dataIndex: column.dataIndex,
					});
				}
			}
		}, this);
		// }}}
		// {{{
		// check items
		if(this.checkIndexes instanceof Array) {
			Ext.each(this.checkIndexes, function(di) {

				var item = menu.items.find(function(itm) {
					return itm.dataIndex === di;
				});

				if(item) {
					item.setChecked(true, true);
				}
			}, this);
		}
		// }}}
		// {{{
		// disable items
		if(this.readonlyIndexes instanceof Array) {
			Ext.each(this.readonlyIndexes, function(di) {
				var item = menu.items.find(function(itm) {
					return itm.dataIndex === di;
				});
				if(item) {
					item.disable();
				}
			}, this);
		}
		// }}}

	} // eo function reconfigure

	// }}}

}); // eo extend

// eof