CREATE FUNCTION fcn_bef_logradouro_fonetiza() RETURNS "trigger"
    AS $$
   DECLARE
    v_idlog    bigint;
   BEGIN
    v_idlog := OLD.idlog;
    EXECUTE 'DELETE FROM public.logradouro_fonetico WHERE idlog = '||quote_literal(v_idlog)||';';
    RETURN OLD;
   END;
  $$
    LANGUAGE plpgsql;