CLASS z2ui5_cl_cc_sample_favicon DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA favicon  TYPE string.
    DATA check_initialized TYPE abap_bool.

  PROTECTED SECTION.
    data client type ref to z2ui5_if_client.
    METHODS display_view.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_CC_SAMPLE_FAVICON IMPLEMENTATION.


  METHOD display_view.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    DATA tmp TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    view = z2ui5_cl_xml_view=>factory( ).

    
    
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    tmp = view->_z2ui5( )->favicon( favicon = client->_bind_edit( favicon )
         )->shell(
         )->page(
                 title          = 'abap2UI5 - Change Tab Favicon'
                 navbuttonpress = client->_event( val = 'BACK' )
                 shownavbutton = temp1
             )->simple_form( title = 'Form Title' editable = abap_true
                 )->content( 'form'
                     )->label( 'favicon'
                     )->input( client->_bind_edit( favicon )
                   ).

    client->view_display( tmp->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      favicon = `https://cdn.jsdelivr.net/gh/abap2UI5/abap2UI5/resources/abap2ui5.png`.

      display_view( ).

    ENDIF.

    CASE client->get( )-event.

      WHEN 'SET_VIEW'.
         display_view( ).

      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-s_draft-id_prev_app_stack  ) ).

    ENDCASE.

  ENDMETHOD.
ENDCLASS.
