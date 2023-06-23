INSERT INTO public.users (display_name, email, handle, cognito_user_id)
VALUES
  ('Augustsz', 'augus@allfreemail.net', 'Augustsz' ,'MOCK'),
  ('Auguszzz', 'augusg@allfreemail.net', 'Auguszzz' ,'MOCK');
INSERT INTO public.activities (user_uuid, message, expires_at)
VALUES
  (
    (SELECT uuid from public.users WHERE users.handle = 'Auguszzz' LIMIT 1),
    'This was imported as seed data!',
    current_timestamp + interval '10 day'
  )
